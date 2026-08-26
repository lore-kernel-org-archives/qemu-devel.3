Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55352C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHqO-0006ea-OQ; Wed, 26 Aug 2026 13:55:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHqM-0006eC-DU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:55:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHqK-00089g-RW
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:55:22 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QHJ5GP1911165
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:55:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 N+D1dHFIktfWOUtW20rGGierHYR2ew9U5aCa22Ma8B4=; b=Db3Eh64G3/1/dhQn
 DGnNMwGUw6E20COHcfPjREIbO0WCBuMQ20pD14QvxB8bbou1xfVbX9BlGu3wOFYP
 FRT7jMdhj75M8tTK885ZyOxbaX4qEXA5QK0zMnPI0rPR+SUbfTU2gpbxqs0XMLjx
 xln4+6f+QYWgqFxPXSJEcL8d8i7fB4Oup/klvteOPgX79tfqUh1PvwTqKnLr7qz2
 jIXRNoQVR9Y9L+i9bJEyjm0oeVLIqiajd792ktPc93nTcolPEFJUk5rMcueovmDq
 bprCweF47sdBWlGGdWYRg70akn+BPGbqhnVKdE0FOZr4CyC5N5ShjHK5eKPYlK3/
 DdUINA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4egg4h8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:55:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-52ee59064d2so2126791cf.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787766918; x=1788371718; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=N+D1dHFIktfWOUtW20rGGierHYR2ew9U5aCa22Ma8B4=;
 b=WcpLY/gRQrh5bAIM7PXdj0sURCHP7YC4wbBFwmm5T0cea6deKMewmlHDe2FpOVOy9f
 bLcV2av/etX3KWd9QoPgA2HLmNpKdeSDXWhYCrc5N0W16Hl2foPabevx3JTIk48i35B0
 BLzWPsT67Jnln3onOjKPe7ezL5qZIJ5li/9meHvZrOfEoLePgAdr0sJ8w+q2JYEDlEvh
 Igg4D5F3BHSueH1YI0bUsrDAk6KtYs2JHXoSV53EOWu/Bbp1w8Dz5zypQqGxciW7UF1y
 O3gKP/S9E/1aYfBCK0x//SyB4lblQQVpwY+kBQm0IRsI/xRyuearxJ1w6F8S1T3i66wA
 aNew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766918; x=1788371718;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=N+D1dHFIktfWOUtW20rGGierHYR2ew9U5aCa22Ma8B4=;
 b=UHY31XhTxNgQUx/I/ER+5Kkpk+clyyrj1PkFxrJh0mG0ECCnKOdTX5Ff1HfJBRhB2C
 J12nTOYU0JcVDCbOc+T86FE2DlNIFY0cazHjDQEuNX3EqW3AQqwm8KiX+QfAm7L5uqwZ
 s9Slredl+oJQ55IyEJJn/rH/PJwKq99YEEidxRBY0z8x1kSpXF+diXp0xahvwxvZuWby
 QKqpnbUsP7xcgmHwvpX8BxPGkEw7uqLObLSjGy+zMal7/eiZAHBesmUP+6gxNr4wec4P
 Kwl5aZbEdwnRdQxPgRiTOyAFYcwI8RwPlbhn7rcHhUD8YDXOxg+H7cRdjfKrI36do81v
 Cobg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqBdlxOc8q002vp430LGzBs8gRgWhkooLHHvyy6sHb4F/MSpWCxzAiTu7BnNxjNrlCkIWWzBQNky1SB@nongnu.org
X-Gm-Message-State: AFuF++lPH4XtwfSuU4fVCmA9pgwkXA11gUeJhmWtbRdp1JRww7qFjig3
 lSnbvlSLz324LEDYWMMyyqghaoNWXQQAZHLhShZwtbPpxWFOyS3tRpFpdets3HSHRyee2YAvkH7
 HCS2gu7ef1D466mzD7F4/t0ikzEDdQRaxW4lFSlFeBAz4hPn4N8RIKnSJJA==
X-Gm-Gg: AR+sD13OMIfLhCxPOzmgO7QdXB1nItC64GYL9XCMp3A3O6uRugtan7WlBY7ZurY7hi7
 tE7A/HNLToCIxgTnuuHEcNOppUP/Nm8QHlGd0fIv+6XUcqf+8RkIGLSCoihXnpMpMfOt+VR2iLW
 bpk7JzcdNr4I4A1t5cN7TcNcMul6FJTfzwm1+/CiGQ1flC7fGrJB5SE/UNSFu6Gii0BI6aUjmjV
 EmQTGk8m3gNwltZ1L1jjHImeLG7NylvTL0bmop/bDrdH+OeeqxJsPYsRJcRmL9HU8KxiV9H9DzL
 HAp38SjdImtIJo/R9XKJOg+WsD8I3R8YJmo2n4/awLz1EV4FBIFBEHULQo2UIQ6KX48BI8sxIGu
 810Sl1h70iE9qSKWbjek1vTu9BujdzH2SM6FjyQAgWaI=
X-Received: by 2002:a05:622a:2d3:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-52fa1a9aa93mr10471041cf.9.1787766918560; 
 Wed, 26 Aug 2026 10:55:18 -0700 (PDT)
X-Received: by 2002:a05:622a:2d3:b0:517:6fc2:4760 with SMTP id
 d75a77b69052e-52fa1a9aa93mr10470361cf.9.1787766917986; 
 Wed, 26 Aug 2026 10:55:17 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d68desm904935366b.10.2026.08.26.10.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:55:17 -0700 (PDT)
Message-ID: <a75ef05f-9357-44ee-91cc-811375bfd300@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:55:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 29/49] monitor: isolate HMP declarations in hmp.h
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Amit Shah <amit@kernel.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Anthony PERARD <anthony@xenproject.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Samuel Thibault <samuel.thibault@ens-lyon.org>,
 Jason Wang <jasowangio@gmail.com>, Yoshinori Sato
 <yoshinori.sato@nifty.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, xen-devel@lists.xenproject.org
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-29-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-29-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: I1joOshvTiSc27JYPBaum0dOoDC6WMru
X-Proofpoint-ORIG-GUID: I1joOshvTiSc27JYPBaum0dOoDC6WMru
X-Authority-Analysis: v=2.4 cv=DsRmPm/+ c=1 sm=1 tr=0 ts=6a8f2887 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=3WJfbomfAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=PA9M43id2i3nLZc8FP0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX5PI0QRn9JpW6
 aglm9BaG2JasOl6+J2naDJjUAAX3UpMTS3feXOOSPgkRu9zlSB83bS9NDFU8jajOwgWJo4+uc1q
 14oXXyitVLbMWDOb7Lw2fjlV1LzVY7jHJaejWrSCdQtyMyf9CE4snQMWRCWhEoAHJiy3xHBplo6
 7fGH9bnExfHZrOglIEwerIJBpsBMtPH1nqC0jIljApgWe6j7qOI13X5OVt6+gcb7/L6w5R3tEQM
 uT6isux5COUgtTkpP9tZuYRAAdcoFcmrWYBYxBb5LYUBEamDmZ5IZVnKdl5BXRwVKoNcPvLAKk9
 PBBgE1tfp8N4FfroYCFbQx61p9/tjp4On6ewxP0nrI9BD5m/jSfMQ7jQpqDQdpJf0jGmSpjagSZ
 B9isv6LdN3Oh4onQ0c2q8Vf9yPI2v2jBAolmfqF9ioiryr9k5bKATliSbscM2CPWfjtOo/WINH9
 FZ1xXww1N1SdBazARbw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfXz3mpBflWsxSu
 9KDobWLRbvvzC8+K0TQGvMbvE3tFYkuQl9hULYuPCp3fqzsq4wWRnjxHtiF1VXSDGuvaeLjpoQY
 EiDqWXV+ur9UjSL+mVYDU0bSg6IX4mA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 malwarescore=0
 clxscore=1015 priorityscore=1501 phishscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260149
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/8/26 21:09, Marc-AndrÃ© Lureau wrote:
> Also rename password & commands with hmp in the name, while at it.
> Other functions need larger changes which we will take care of next.
> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   accel/accel-system.c           |  1 +
>   accel/tcg/monitor.c            |  1 +
>   chardev/char.c                 |  2 +-
>   disas/disas-mon.c              |  1 +
>   gdbstub/system.c               |  2 +-
>   hw/char/virtio-serial-bus.c    |  1 +
>   hw/core/machine-hmp-cmds.c     |  1 -
>   hw/core/sysbus.c               |  1 +
>   hw/hexagon/hexagon_tlb.c       |  1 +
>   hw/misc/auxbus.c               |  1 +
>   hw/usb/bus.c                   |  1 +
>   hw/usb/host-libusb.c           |  1 +
>   hw/xen/xen-bus.c               |  1 +
>   include/monitor/hmp.h          | 21 +++++++++++++++++++++
>   include/monitor/monitor.h      | 18 ------------------
>   monitor/hmp.c                  |  8 ++++----
>   monitor/monitor-internal.h     |  1 +
>   net/slirp.c                    |  1 +
>   stubs/monitor-core.c           |  1 +
>   stubs/monitor-internal.c       |  2 +-
>   target/rx/disas.c              |  1 +
>   tests/unit/test-util-sockets.c |  1 +
>   tools/qemu-vnc/stubs.c         |  1 +
>   trace/trace-hmp-cmds.c         |  1 -
>   ui/ui-hmp-cmds.c               |  4 ++--
>   util/error-report.c            |  2 +-
>   util/qemu-print.c              |  1 +
>   27 files changed, 48 insertions(+), 30 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

