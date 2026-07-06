Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064BAC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 20:44:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqAE-00007o-79; Mon, 06 Jul 2026 16:43:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqA4-00006s-Uv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:43:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgqA3-0006Yk-6T
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 16:43:28 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KF22v1667353
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 20:43:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 mw0ZosaQxShWjJD/jE1atDqLE8jtwZU3wcQuPMzcUVI=; b=QYPuW9nCeduIOWEs
 wvzUY7L1xTSR8/ETfkOiEoC493gexVoAFoJrvp6QskX8cejzJ2ul1ieS8+eriFIE
 GiCEF7c0HEJ6Jy0H35ro4yQ213R4+QlJeH2oJ8NlLZ9uhfl8yEpkWYwRq45nSG7y
 Rxlh24ukVfw4MHEhoptOcn53I/7TlIHs7Bc+fEo6zB/8J7nqYigMQulkA8cApQlj
 c9svbzdWKjgr1pMWW+xdfcQA5Fxp3KszqcR0Xev6GF3koeDl1D90HDu63Haoli3H
 voJSVPr7Ird9CmfBbWM7ZUpT1kRhF0cahYrRdf80XxJWZn8d0TY392KcIa9NhZVp
 7/c08Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8a3gtuhj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 20:43:19 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c0199faafso39260681cf.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 13:43:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783370599; x=1783975399; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=mw0ZosaQxShWjJD/jE1atDqLE8jtwZU3wcQuPMzcUVI=;
 b=ctYeDsAbibixNJFOBv2rZHQpqmebtwixhoH9ZNdG1pBwrYH5HsA0O8kwCnc27XFlxY
 EdV7xQk0dFlUfy1gb9zVsex7C3bPuO3BJl/mu0b3vgYjrT45s6peIrSRevGKunFGptqu
 qg6y6plym3ovJkelbbkdRajTF3CjeLhGAbSeUo6TRsKUFJn/cYbzA06PprHKbROlCI6O
 CvJ9+omO3DQVwlP4Mu5XCq0757LegT7NpAjih26AKu8bENAq6HwQ42NqmHOQ+xixx/MH
 4NpEx92ohMYojOfJ9X8ty6PljCkxKz8uT8WNv9nejCGHHVurTUFgy9XquhLHeppCmW8N
 tSDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783370599; x=1783975399;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mw0ZosaQxShWjJD/jE1atDqLE8jtwZU3wcQuPMzcUVI=;
 b=D9RJP+NxOK+T4crSkaGNUbnl9irPPDGj8Fawl9UX3kWWneZguEqyeyVnGpQRilZiHc
 H8M14Wr6WzwCOXwmAoPMaa6G2qj55ks8PFFa0Rs7S6gHcKhiVERx3mvMa1YcXk+8hdas
 oFAIbQnPtsq872U54xEVdFoyMAFzvcxyUAA/oWWpQOmkUJBQw+o/mPQXxZ2DZExkFvXY
 s4xmUJdJWxB7EkHh3P/0ah/APAzBaBV13NJxkTtgxiK/BEW2eVF0ZvF1n2oKrWXE04jD
 msFwB2nS/9FV87oQqgGClRTq/OHfjBMqx3QvjSKpLm9oKRhMMD6j/vYc+9ViR2pIcL6q
 vFpw==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro5P8029AAl+6ml9Mb8k/kLfRepa6f5VmXj0qDp20JMVHQUh/oLTh0pkh6ptBSISAaNk2LllQhVYCOs@nongnu.org
X-Gm-Message-State: AOJu0YxxFpxr+NEVS1q7S+E6KHy11TtRQmv8oWuyqm6MV+bBui8s4OAX
 q0aGQmLiEUTdMZ8W41x15AU4odaDDFEIGvHDGIQn/s3iZF7XxWTjkNmFJr1YJlfhGg/bwv9mDdi
 9hab4nVAR8PKVtvdNIb8J4re4spOA3e4oyMarttEYEZ3cO2hg549Zql93hg==
X-Gm-Gg: AfdE7cm8+So2Cb/Y1Rybo4f2px5t0hck885NUp+xlj07GEEXBlHUCoYXArVxfdDmofj
 n6npzu/HabS1cYRfUKhpENaixIBAfr2OulQVFTzcNdrF+bNfv5CYCq/allTQoM2+RWCowu2I3jL
 rvgH5KUYvOo06qAHWH+1zdHDV9FRk8ahjJZlOZIceuV7TMo9X5nYKf/GX44XiyOcxxsEuEghe7d
 J7zknGluv3DC/ApRVjqDxdX3n+qeq01qQA1OpDcik/ctf/310704rwQ8SrELaYy3oWV2j7/L9PR
 Nbgf7RDr1ny0icRH6jvbcIatHvXGoF8nEwAC+dCRSaEMbndsIWCpDtcehWor3qiJ3TNsCZ/J5GI
 lcWay55X+x/cM+6N8YxRx7feK6M6B/qJNWfiKWv/fmYJClPZMbix1TZrU35rcXw==
X-Received: by 2002:a05:620a:8803:b0:92e:9d63:a6f4 with SMTP id
 af79cd13be357-92ebb4e3acdmr294859485a.18.1783370598771; 
 Mon, 06 Jul 2026 13:43:18 -0700 (PDT)
X-Received: by 2002:a05:620a:8803:b0:92e:9d63:a6f4 with SMTP id
 af79cd13be357-92ebb4e3acdmr294855385a.18.1783370598188; 
 Mon, 06 Jul 2026 13:43:18 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0a55be4sm24817002f8f.31.2026.07.06.13.43.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 13:43:17 -0700 (PDT)
Message-ID: <aaee2b54-01df-48ca-9c83-796069767ca1@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 22:43:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/usb/dev-wacom: Don't write off end of buffer
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org
References: <20260706182034.1003176-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260706182034.1003176-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: _aQzpBrE3s4I7GE1j6h4QhWhIp4a5FhH
X-Proofpoint-ORIG-GUID: _aQzpBrE3s4I7GE1j6h4QhWhIp4a5FhH
X-Authority-Analysis: v=2.4 cv=CPYamxrD c=1 sm=1 tr=0 ts=6a4c1367 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=69wJf7TsAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=Qp4y8eNqsPY20014W8oA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22 a=Fg1AiH1G6rFz08G2ETeA:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIwOSBTYWx0ZWRfX+bCzUC9y+5AX
 geGRefewHY8P+FSl2uV1cCRWQE9I/BQshAh348abZNcLL+yjWguWf6JYQulkCEXxgJ1f1s7mO9E
 SFNl5EnLwGKWBB20fOyXr94DIGo2f2gJ8JVN3bQVNN9oRni6SmtGt724t+z7p0b7cS9tMxefArK
 Jvnf4AcDW3hn1MA7DnYiaJPJ4SxNVDJEN50ypR0dW/ZE2XICVhZMzZTOqLoVoan/m0CzPbUlT6G
 XbE4N+OfMw3quCKwNvZ8DGp4uCmzFDLiKKg0DkDPkosN7Ci3EacRjnScR8vEYuUiyiL0CT+yaY5
 ZUBKKEG0Kzm1K3M07CvCE5pttBbJVK5HABp6ql6dAfIhwXbnQDVyYI3bKXJVxWkwqbitMa7UXxM
 2SH+oHTknzGAQE2Uru0m36espSf6ZPh7vYcCpbDNxXC5DcQxqb0VodupKrHAikh70kWYJ1tjNTA
 iCy5P1NFBb1IMPNYVsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIwOSBTYWx0ZWRfX1uqtsVcty1ac
 o6mNky75MkvzCCu/MqSvc/Ie3g/gcCMVHiQXCkYPor1073XkoT9DdXer49Off49tNQ2JWnzE3ZM
 mWW/ZwAutmJbcPCCu5ivY8QLM/3N77s=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060209
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

On 6/7/26 20:20, Peter Maydell wrote:
> In usb_wacom_handle_data() we allocate a buffer with a size
> determined by the transfer size requested by the guest.  We then fill
> it in by calling either usb_mouse_poll() or usb_wacom_poll(), both of
> which functions take a length and return an actual length, which we
> pass to usb_packet_copy().  However, usb_mouse_poll() doesn't check
> the buffer size as it fills in the buffer, so if the guest passes an
> overly short transfer size then it will write off the end of the
> allocated buffer.
> 
> Check the length is at least big enough for the minimum 3 byte
> packet and return nothing if it is not, as usb_wacom_poll() does.
> 
> Cc: qemu-stable@nongnu.org
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3672
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/usb/dev-wacom.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/hw/usb/dev-wacom.c b/hw/usb/dev-wacom.c
> index c69e247f7b..895edcc17e 100644
> --- a/hw/usb/dev-wacom.c
> +++ b/hw/usb/dev-wacom.c
> @@ -285,6 +285,10 @@ static int usb_mouse_poll(USBWacomState *s, uint8_t *buf, int len)
>           b |= 0x04;
>       }
>   
> +    if (len < 3) {

Maybe log GUEST_ERROR? Anyway:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

> +        return 0;
> +    }
> +
>       buf[0] = b;
>       buf[1] = dx;
>       buf[2] = dy;


