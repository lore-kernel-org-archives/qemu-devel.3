Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35604CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 20:43:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waJZF-0006Be-NF; Thu, 18 Jun 2026 16:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJZD-0006B8-LH
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:42:27 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waJZA-000856-Dh
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 16:42:25 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65IIg5Pt2081301
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bXiO34ZMw2zmryac+H2m7MzM+RESmcCs0p7xyNTLFbg=; b=m3j8H6T3xSHDlP05
 DsOXnhVYgdQkaXMAbD+dyRy+AFMOxcYEyyreXKq3pvh2a6TG65skdIExkk69fEaM
 EVDIoONshs45w32883LhC9w8I89lO4oL64ceYvqcYHYi34C5ldR31fdJhW6CF5BA
 TpEEVgPucOfEYC1r0Y7wk5N72/YU1dqrkpjDLtiO35HLprybZa0bi2ps3CIx/Y3g
 B8ZxGrJbdNVt4/9xmZEKX8AYE/Fx2ionhnYeMB7nB8ePqv5yeHKYn14BxThV6fNw
 WPkUn5lR+aOoiW158xMUl5Ke6sa70X0PHk+0UbK6JIpT1ZRWN/SwaMjBRThFwqcL
 wuDGUw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4evp670j5s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 20:42:21 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9157f453a27so258565085a.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781815341; x=1782420141; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bXiO34ZMw2zmryac+H2m7MzM+RESmcCs0p7xyNTLFbg=;
 b=QJEedISdgY1HbY+EZ6TizOPtFTtbWX7SjXMdDaRTvVLSlLdpe85QVu9p8MU7oL5AQE
 wEqbRoVRTHYnYKrc8Q5xUxBTTWlKquDuklmWKOaD9KQ22U/xxzPw9unI2HSBsluxbVM3
 bU5+xHq3WBtdemGZspaU8rttBUls4f2eL5skKtya+DV5eL0CGBJaIzEX+Dge1WZ98JUv
 Y3+yzMvvQYahCm/QjQsoxLClNSO/79Ske6sttVi0aT1Fw7fAQkmsEzF4QljxRH+CKqsX
 j+8W5M5U+bE7SwIEnvObt1YzKCC5ZolFvV6fFhtVhm54EStCbXOzlogtC+y7TJp8ZkaB
 ggnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781815341; x=1782420141;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bXiO34ZMw2zmryac+H2m7MzM+RESmcCs0p7xyNTLFbg=;
 b=qzu9PAqyXlmikvJFsTpVueZtrR2WILYHrPYfMjTtm2YhhjbH3wOL/Fql50xp8QrdSq
 MhlSebLyI6OWb2AgieNC2GXcvB5YmENYFEqe4Lby1rOrcMseKMVjZ4J1yrm8ohPFfHBO
 GsrFTQaP/qf1OB6FD12oXPDNP0+wNN+blw+AmM2iS11mqU6qn2QHtqPGnz0ouhhmU75Y
 3oV1nG64JrwKUrj3YN4qqvb3B4d6HrcDxyFNgRkd0glst1CayW6efz1BwDw/4mMpaTfb
 XcsvTyAOEEvtJafte4tF12A67G4AM4XnmyCA0nW8hdr55wciT6KEXYwxUq7LhraLAZn1
 eXXQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8BUyMh8ptANIKBIp9s9qSJMkMzLSWZ0TnIffj3hUbbB6JRXHP1uyuAjLGj/wv4uFvNAPfeyVi5XMsr@nongnu.org
X-Gm-Message-State: AOJu0YzCkgkRz9ORWe4SYXiVXoC4EkhqFYxv4jzik9jnVhiGIYV4xxC7
 CNzq5qykXW9Js7iQAVtqTYq7CvZub1yNsXfkw+Zl5e/cPxi+XYCLCq+T75Qn2H1S1pr4hJunpFD
 yPUM3P0zxknnW9OfPg2HnwO4o+3rROrHdAu3f53S2dmL7W0ZULhZ6xRdvZg==
X-Gm-Gg: AfdE7cnAUHiVUFGX/vJrFy+suA4HQrJbm4gEXZjRJUhHLIcDAHffBlAOukGlzTnKW80
 So0hEx3hgGS8j590wnCyjBfRC3omBHbN5IUnRVMpYCuPeu653aKP30F2gUQ+x9r0CpgQMMv8wYW
 63Dj7SbRUuAgRtAZDzRfV8NwvNdvJiftPJ85Lm9DwX6d0/pHR9IDhFUqDPej/rcyz+3Dxj+OZjA
 oN7y96Ifli2UAS+aximLghEDW38qwk32NiwPl18ubISnbEdNmklWZWbh7C0jMz+hpNID/TqNuaw
 NaonXVjzz4fIvMPXjtO+OUjP4ZbmSF4bXYwe64Qmq9IgO1VhtSzQ654Zglu2D4IwIKc6yjNNeiM
 +Iu0cT5B5iq6vgeMd/hgFPfmWH1nHOYWYPcdsXoqkeq0psVO7fTJqRIA5jBxOWw==
X-Received: by 2002:a05:620a:6499:b0:915:92bf:560f with SMTP id
 af79cd13be357-9208d8e4241mr111208585a.36.1781815340932; 
 Thu, 18 Jun 2026 13:42:20 -0700 (PDT)
X-Received: by 2002:a05:620a:6499:b0:915:92bf:560f with SMTP id
 af79cd13be357-9208d8e4241mr111202485a.36.1781815340478; 
 Thu, 18 Jun 2026 13:42:20 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4650bc42a3asm1586883f8f.31.2026.06.18.13.42.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 13:42:19 -0700 (PDT)
Message-ID: <afe3e819-b36d-4e9b-b9bb-1c978a5b0f8a@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 22:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 03/12] system/memory: constify section arguments
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Zhenzhong Duan <zhenzhong.duan@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 qemu-rust@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Fabiano Rosas <farosas@suse.de>, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 kvm@vger.kernel.org, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
References: <20260604-rdm5-v5-0-5768e6a0943d@redhat.com>
 <20260604-rdm5-v5-3-5768e6a0943d@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260604-rdm5-v5-3-5768e6a0943d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Y1qF5fI545jhvc1s9Q7ujQ6ngKe4ijKn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX+/aj7eLY129U
 kGAQmRvYNksC2oz3DdZoCTOz08EVo7sQDIuGmhGReJq62cV1+uRSsER7BD0z1Te1MiHjRy3Glfb
 XFONufIP6m502wEyjHxHXmW8A6xKCxRUK427nTgA5MHTIQFmzDT7jAC/L0o42IcCsNzmAr926SN
 Y2QrsqSrAolxuDa+7r532LFKGuVP11n69Qb1mgaRJu6ZlLnklSgtfBLdakiUGN8wqX1Fayfm6vn
 a/j0VAUXVszUVbM1Cl4wLRjCMDW9ti817RhsGwPvORtUUQ2mbUzyF6dGO3PEiR9Uyr4zXHD+VF/
 CLLM8GAcmVZWFnv0hWMRbJRxkhnecfLa4xpOiblJd7r7lxw2qNk+o7yO5hc4Nt2Eoiw9KwWTFdn
 XQvxag8P32UOFvd0s9PezHq7r1UtZNMy4+y4n6sCzSAe4FqY0S15u/bxjm7EhpZsO2hmYJYA1Om
 CJ7suTZFN/STy9blwwA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE4OSBTYWx0ZWRfX8Ipyl2rqg5lW
 6lBo7hoSj1JoXsTw91BiIPeBOOS05gfW5wng1FK6sir8/yNLmYbKopLfRlNhVZK8JifQUnZI2ta
 fKuJCx3lPrgsvjsgeAxyiMNnKSg62BI=
X-Proofpoint-GUID: Y1qF5fI545jhvc1s9Q7ujQ6ngKe4ijKn
X-Authority-Analysis: v=2.4 cv=TdOmcxQh c=1 sm=1 tr=0 ts=6a34582d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_03,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 spamscore=0 phishscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 bulkscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180189
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 4/6/26 15:43, Marc-AndrÃ© Lureau wrote:
> The sections shouldn't be modified.
> 
> Reviewed-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Cédric Le Goater <clg@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/hw/vfio/vfio-container.h     |  2 +-
>   include/hw/vfio/vfio-cpr.h           |  2 +-
>   include/system/ram-discard-manager.h | 14 +++++++-------
>   hw/vfio/cpr-legacy.c                 |  4 ++--
>   hw/vfio/listener.c                   | 10 +++++-----
>   hw/virtio/virtio-mem.c               | 10 +++++-----
>   migration/ram.c                      |  6 +++---
>   system/memory_mapping.c              |  4 ++--
>   system/ram-block-attributes.c        |  8 ++++----
>   system/ram-discard-manager.c         | 10 +++++-----
>   10 files changed, 35 insertions(+), 35 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

