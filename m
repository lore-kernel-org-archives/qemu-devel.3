Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AB84C624D4
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 16:20:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1ngl-0000rZ-P1; Wed, 02 Sep 2026 12:19:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1ngk-0000qz-DH
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:19:50 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x1nge-0004RI-Qp
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 12:19:46 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682FconT1806927
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 16:19:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 uH7GLkwMaomRbFfMvbtkPvqF08Xr0Ep4Rn1LKlzYiSU=; b=DyqX24s2LCZTw8Mp
 R3ToAZ9oE3Z6gRJd3wu9251TMSEbO077WMYgjoGzlxyKocYC3cYMMPWMjoQtpWEA
 GmnenGOuTV5ITbjzW85Gl1jjXzlrBYuig2QM5Qvl4cx9BO+jkuQW/xUyBpAjY1Oe
 /XFp5vSMGK0ZtfYYMh/P43QDCQJUCL6sySoEDSjAeo1u3ITxSfq9PkgSD3xibH+S
 c/2ONq+WaYNpoDDUWIWfNaz4hXL8U6kAt4jEKF2gaiqHPkW1jSJ2PiNIB6X/ZZxZ
 XjJgOMbdjQeAARzNG/fKsNH9xjKhG4uOZ6NpYlSwA+cHxxtDLD7hotBjukXb5wty
 fybV1w==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4genrdrcbe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 16:19:43 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e82060977so5369885a.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 09:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788365983; x=1788970783; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=uH7GLkwMaomRbFfMvbtkPvqF08Xr0Ep4Rn1LKlzYiSU=;
 b=C/Qx+bWJP5AdSHj77KGDR4ENwc22lesUvlOikLiq4PoKCREc6hFGDpVBHo748GemH4
 +8PUnRNvSkPWhiv8UM/frQSorGRG62G1M9FVfHWTBYTwaeP60nhf5UkJa+nldhPg3F+U
 ww7VZwt8FGLoGaTwhxHgEu+G/7ESTwh9pEWHRAxS8ITpeg7r+MLYWh7M4AnSuF686kFq
 WyZnhrfWifbszBQeqW9/xpq4DwfoGNarVZItFjZsdM8q+zkBCF9zFZrVTogO6sXbs587
 dD2S/TOoIzdeeHY1i3hOmBz4CM+L2h5M8am9Vp1vDuwzQAhebk5FghbuERkvSf+KJZbv
 nb6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788365983; x=1788970783;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=uH7GLkwMaomRbFfMvbtkPvqF08Xr0Ep4Rn1LKlzYiSU=;
 b=rh8tKI1j+SJLumqepv9G6sO5GhveGPRvAwp+q7I4JAuNFBgZ3W/9PTViei96TGfBLb
 q0/ULNMbe/DHj0MdP2ah3s9WJc2MFSoGk2fRP5sgdHfdLPIYCQ2W62dnMe9XrXylW8+8
 iYsYWnDJx8O+B9hwsgxtQ5p7GAUll3XOs1LLpNwX+01Z4KeBmXXG6U2yeGUbNdm4baro
 rLmgBcDaCYo/FDrrEZTpLRHFy1bdb4sy7ne0g12JBJ+72mYE/0wLq2gUQKcKHribAWxl
 r3ZNAACjiKI0EOdyqTFy0qVpQsRTZtNDlkHmq6dtVocrw+kupNlnSGJBWyMUs8scZY3M
 SDvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoB7aiQKfRMkwoGf6V3bqAZs95XxYTKFOIuXhSO+6gUkaQCzWFYoxohz+FIXU6Nou31XwX3pbtvuyIX@nongnu.org
X-Gm-Message-State: AFuF++lK6cbpvV1FWaxqVa4cDolO8Vg3xOPAkAHxOsX3ELKBuojlDuR+
 kO1lL/4bv35+VPoAihkSysllabRAsL9vGJosyZj7qfMgm0AUB/4ALb/40WENREMF0odkkADi78X
 FUopg862px/3i5a4oVz9DH3tMCAR2gvvvimW8Evs7R+OJZ/bLjXmUYj1z1w==
X-Gm-Gg: AR+sD11rhlg1SSOmldOYkh5hgBEckR8TVOMJ3svTnLdkuCspM/A6KLX542StdCH0W6D
 D1y0q2Tjzb3+kilzNAu7tKPZte1jcS9YUJDzMMXXkBEpyPImh36/6gJpx8axzimnjW12A5MND9K
 cXYVM0G8OqaTTXmgMDxCbdCloG8RHEv6QvYoI582cz+20qtQxzS350mSUYc0K20yCri/EO2bCx0
 FPPNUMaE88d9YhnUlHn8lHSLqjg2cI5ednIGFsSOJ5kx7cdX/X03tbtJcsbb95md5C4aB21Xoh8
 /Xvg3Dbq/4ZEk0oM0sUZ5EoZM1oAOaxvnObLiw66LdhQbEEWUubFLvBGGcWfdOE1HrRE77sdUhd
 r+x3WCy7GdG/IcWag2uHsdlATpoUrpNgO7w==
X-Received: by 2002:a05:620a:88e:b0:930:9cbc:7121 with SMTP id
 af79cd13be357-9396deacbbdmr42273085a.3.1788365978212; 
 Wed, 02 Sep 2026 09:19:38 -0700 (PDT)
X-Received: by 2002:a05:620a:88e:b0:930:9cbc:7121 with SMTP id
 af79cd13be357-9396deacbbdmr42266585a.3.1788365977557; 
 Wed, 02 Sep 2026 09:19:37 -0700 (PDT)
Received: from [192.168.69.200] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee60d9c6sm2234235e9.11.2026.09.02.09.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 09:19:35 -0700 (PDT)
Message-ID: <a3ad2419-8412-43aa-bdde-98dd1e3346ce@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 18:19:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/block/pflash_cfi01: Always set romd mode when clearing
 wcycle and cmd
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org
References: <20260818115742.2268257-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818115742.2268257-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=H4/rBeYi c=1 sm=1 tr=0 ts=6a984c9f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=cHMopGNo39Li6iAlKhIA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-GUID: xe1cq9KZ5nX3HPnrsNCpYwSLdeKZLUzx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfXzVrc+jZxhM/a
 WsSr1SbnmD/i+mqobjw0XD2Rdr2cn9AWUsMV/0stj8Cw+dOn0ue2pIO+XOHfD0vQZfdmqpl70Kz
 YhJ7sq5hisNRfVgCMzXUxELbbDy3g5DEjeml8BfcF4fVhcDVQNpYBnwnUblsUX5vm9LbTM/neGv
 Rp9KFeat53B+9KqYn6H0ChWbooQR4gOhG1vUgjpIAPfmwxFAytIaXRoEDF/p7UpTuSR/5NMDnLT
 94THwTAvoblUsSzFpSNtIE/8YrmI2hYKAJtbZvjZxCRYYdv3bPqs/lff7+FDvFP55N3bwqYu4Rr
 wC91tbXjsIoLmOvpjY4aCCfddcax+U99zKCgx25j7JMJ790tIvZ9CvzFsELoILRTswT1yolplcP
 9SJMcG/7AlXJgM6w3xnftkYQx9RT/ZU1dnTTdeGUyUKMBeNBlsLB8iCfSYFnEXjJ6NhFxfhdoJz
 hdIkjqmPxmQWv0dcymA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE0MyBTYWx0ZWRfX3l+mmhp9GHft
 d5GyW/nq5Mkq+/3gzKRXRYbN5YKvHFM7qd1q85KqqFmCPLUAGTPq4pJG0nxP6giYLVkcAjzl80o
 /kCx18DniLGKK2cYdZGCn+Q4hc7h/nM=
X-Proofpoint-ORIG-GUID: xe1cq9KZ5nX3HPnrsNCpYwSLdeKZLUzx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 phishscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020143
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

On 18/8/26 13:57, Peter Maydell wrote:
> The pflash_cfi01 code has an invariant that the MemoryRegion is in
> ROMD mode if and only if wcycle == 0 && cmd == 0.  We rely on this
> for setting ROMD mode on an inbound migration.
> 
> There is one corner case where the code clears wcycle and cmd without
> also setting ROMD mode on the MR: in the "should never happen" code
> path in pflash_read().  As the comment notes, that code really is
> unreachable (unless an inbound migration feeds us a bogus pfl->cmd
> value), so this isn't a problem in practice.  But it does make the
> code a little trickier to analyse.
> 
> Pull out a function which does the "clear wcycle and cmd and set mode
> to ROMD", and use it in the three places that need to do this.  This
> makes it clearer that we are preserving our invariant, and tidies up
> the loose end noted in the commit message of 60d010f66f2ad7
> ("hw/block/pflash_cfi01: Restore ROMD mode after migration").
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/block/pflash_cfi01.c | 31 +++++++++++++++----------------
>   1 file changed, 15 insertions(+), 16 deletions(-)

Queued, thanks.

