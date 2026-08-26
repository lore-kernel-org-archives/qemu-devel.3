Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 681FEC61DBD
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzHpK-00063M-JU; Wed, 26 Aug 2026 13:54:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHpG-00062x-Py
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:54:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzHpF-0007js-7m
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 13:54:14 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QHMA0C1044511
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:54:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Sp27iEClLUQq6n9BKYnr24PuStqwO3z1G11wcGJ4R+8=; b=YrhCuf3pRL/yN2r+
 23HO+qR5OfBL6eD8khqZfMmf+fFeIWG6lK9qR4cZEEBiFvDZ/SGdM057qpx5I0xL
 wSAttLsWmGVwBacT28DWoawasBxxIb7ksUKuDFN3adCDDCF3xkCh3FCXIJIawUjo
 Lpp2GdKidDZF8jF+FttszPA/bIBaX8hmkUVmwzEzaqFZss9Yv5POqyGuNAyFBhbF
 26FP42rU2GiesE1svLSetQg8VjKfgAdSDiWWPM3t890lUFYgBnc64Dq8R20BNbR7
 hGlYiXNAyA74zPe7/4DczAmsIGBTYONXF08qbgwnertOoLoaIM8ZHPWwI7HjR72z
 +SaEMQ==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga4fwg4dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 17:54:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-90cd2cadc62so4022786d6.2
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 10:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787766851; x=1788371651; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sp27iEClLUQq6n9BKYnr24PuStqwO3z1G11wcGJ4R+8=;
 b=QR26CVM2bZbJnRkYbh7a4ezkDE4oFuzICoqi0Lvrtwk67JLz+7c580yb8lqxQ1jmmq
 pzGrN1SGLc/b1bQrXVh0g7i2cC1PhzHfzTeLCzZeQ7KrhDPyMM+olUxpAR0XNJe75H4h
 lITfN41HvxWj4Q7tRmWJRiGUoJV1ZhlvRg0jaag7U0EDudgeUogUuJeuNsigy5Nbrulx
 jXI4Svvc0yOX7wponexRXFljWE+9jOyMZUM41YxRHYDsWfENJGveMBozk3WrrRwre4jF
 pU80wHqh6GiM4cndX9kbU0GWZfSUXn6ZxRETrgWdY6VXshEwG8uWBEurjqP9LzbomWbN
 aWSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766851; x=1788371651;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sp27iEClLUQq6n9BKYnr24PuStqwO3z1G11wcGJ4R+8=;
 b=OG46Liy/uARjv3W+7vqyXY2BscWcKic+9GFR1mm0jOWIQDPzsSPxLXkNQUoHI7hnlx
 FnOqgHUqaP9enH3JyQt6ooU/Wd89QjPUJONqW+NfuCIc8ga0WoAaxh/Lxwig0iIECeWm
 odAhej0F3aTSYwXzHREnlbVORqRycIJaZBy1e698tgOkWv+NfeXOnTjcWbjhltsr7hbR
 k3MwvF9qGJ7LAtrLiKLQkelRld9lToRotnLM0pNGWUS/5xkFQjo8uY+N9Ns4iHIdXwWF
 sv0TgCRHF3mBM73femKFBz2HXSkRi+0DHQuP/VSA3GHLCOuNpMp8XUn3VM4U2BrY6xPe
 Zz+Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrxww9gDNg4UgGuBw6S8/c581femVA266Z5IMkvK+C1rzgWUZk6SYgjzCHnavCWZKPzHpsyScqLRaBV@nongnu.org
X-Gm-Message-State: AFuF++kRTJoCnkaOJaX47Knkl5BJOShnlVZA3Fp1xyn+bBgS6FgssIJF
 azHTQuZoXftXJKc78o05wtHWiadbe2MmU1WV5OscTEdNHPA8SsiqgVF53P/cJLCfRqsmUL3UIEd
 9XAC5PXLhw7W4XtF9DqyW0+CaJANUT9sWZ2FMsYEGOLoViB2Kw/VKKtI9Qg==
X-Gm-Gg: AR+sD12M5GZ06Uzg6r5whDODQsIeXjNfzvf870sqzW0XezR0Xm7pHkwSggSfa9X3DUP
 Ed7m6p6I7BHYX4CzCoEFlCEq7cRbqNhu6hCH3j3wgk4oJgfBG1f+YqJ2m23+g8AWgBdOppFekH0
 DT+tc5nutlZjsxvrIamlrwwDuT05K59NdKaoGjmoGiLMwSCw69Vp7N4QB7kVF00MBHlLvyyCSmp
 kU5Ob0qEgZzCVD1DxwR9cNY15UMYvjZWCfgknfShWnpK2nIzHOh8xa1fJLM7NoAIZRFhTb9z+RO
 zG5QeiawtBPziNIuo4te2/76eC/vpbt6vS5mH6eQuQ+96Ee/ebrhfiia/l7heAO3hH3PbOyOSAI
 rLyj1+ZtZyV7DSuWuNIl93AGWc8NeXQNzU+mbAPmI6Zs=
X-Received: by 2002:a05:622a:110f:b0:519:8998:661b with SMTP id
 d75a77b69052e-52e423226edmr87024131cf.20.1787766850855; 
 Wed, 26 Aug 2026 10:54:10 -0700 (PDT)
X-Received: by 2002:a05:622a:110f:b0:519:8998:661b with SMTP id
 d75a77b69052e-52e423226edmr87023611cf.20.1787766850403; 
 Wed, 26 Aug 2026 10:54:10 -0700 (PDT)
Received: from [10.254.188.74] (134.171.88.92.rev.sfr.net. [92.88.171.134])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a9ec343sm444554366b.57.2026.08.26.10.54.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 10:54:09 -0700 (PDT)
Message-ID: <472aae79-aee8-4566-9141-2ee5448a1f93@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 19:54:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 31/49] monitor: make hmp_handle_error() take MonitorHMP
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: dave@treblig.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Paul Durrant <paul@xen.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Jiri Pirko <jiri@resnulli.us>, Jason Wang <jasowangio@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Hyman Huang <infra.ai.cloud@bitdeer.com>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-31-af60857c2fbe@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260825-qemu-no-hmp-v4-31-af60857c2fbe@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: psCBjD3m5XyC6_nKQNqAwEXizwUzlN_y
X-Authority-Analysis: v=2.4 cv=OtZ/DS/t c=1 sm=1 tr=0 ts=6a8f2843 cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=o1isufRNksZXpKP+aqnsag==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=3WJfbomfAAAA:8 a=EUspDBNiAAAA:8 a=LfsA7Cq2GQzuzbZ-N0YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=iYH6xdkBrDN1Jqds4HTS:22
 a=1cNuO-ABBywtgFSQhe9S:22
X-Proofpoint-ORIG-GUID: psCBjD3m5XyC6_nKQNqAwEXizwUzlN_y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfXywCKS47eWLAf
 9pSMSwqT1Roz8ydbPA65qFPqGu0azjym2AT9WZIUN0c8EG7s+ptGB/1/PjFQaMlFzKyAKjNOhc4
 BJIwX2PXztPmLhtI7652L00EYHlC6veqAgicI/bCprFPwsWU+XgNvmnVOQqArQPUYVb8fXSoEuj
 igZcFRE/uuo8ouaaMuIob2OPhS6w3Bk5b4rviKnWzT8CN7s8DTpXPGJVPdSvRW5/ts8y8iu9Tlp
 qg7bjSlfqcdwf2g//YvkpfbfebpetN2PWv34jKwvyJ0r9TEWSyqqgCSqZGdVhcbLEQLS0pQ0Tbo
 tGhSI0KVAw6Tyul9F6BVLObOHfeSF1R+9Ts/E7s9nXQ6h2JzCj71iDHJl/IIe3+zEUEATSdqWob
 VYd/Uy9/6N56AdcSHi7uZaFt2UFmMMIB8koN20tyWSWzgDInJdTSPmSocNcvFwEPxsOEld565KY
 NY2ZWM0oCjJKntah67g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE0OSBTYWx0ZWRfX2RLJwvUw7C+G
 d5ZCz5Nul3MyCst7U1Piz1c+v+nOiMkKPk27UuquXslIQqOibay2sebcOYnuZuaFpMp6wT9u8/h
 GA6al8S1XpJkLyJsQ+xYJXc7sybohf4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_05,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260149
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
> Mostly mechanical, with a few adjustments around it.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   block/monitor/block-hmp-cmds.c  | 73 +++++++++++++++--------------------------
>   chardev/char-hmp-cmds.c         | 17 ++++------
>   dump/dump-hmp-cmds.c            |  5 ++-
>   hw/core/machine-hmp-cmds.c      | 26 +++++++--------
>   hw/i386/kvm/xen_evtchn.c        |  4 +--
>   hw/misc/mos6522.c               |  2 +-
>   hw/net/rocker/rocker-hmp-cmds.c |  8 ++---
>   hw/pci/pci-hmp-cmds.c           |  2 +-
>   hw/uefi/ovmf-log.c              |  2 +-
>   hw/virtio/virtio-hmp-cmds.c     | 10 +++---
>   include/monitor/hmp.h           |  2 +-
>   migration/dirtyrate.c           |  2 +-
>   migration/migration-hmp-cmds.c  | 41 +++++++++--------------
>   monitor/hmp-cmds.c              | 23 +++++--------
>   monitor/hmp.c                   | 12 +++----
>   net/net-hmp-cmds.c              | 11 +++----
>   qom/qom-hmp-cmds.c              | 13 +++-----
>   system/dirtylimit-hmp-cmds.c    |  7 ++--
>   system/qdev-monitor.c           |  6 ++--
>   system/runstate-hmp-cmds.c      |  3 +-
>   target/i386/monitor.c           |  3 +-
>   ui/ui-hmp-cmds.c                | 19 ++++-------
>   22 files changed, 114 insertions(+), 177 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

