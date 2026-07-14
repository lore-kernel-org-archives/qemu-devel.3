Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E77DC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2026 10:02:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjZyB-0005UZ-3B; Tue, 14 Jul 2026 06:02:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZxQ-0005GE-Sd
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:01:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjZxO-0004YC-0L
 for qemu-devel@nongnu.org; Tue, 14 Jul 2026 06:01:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66E6SRdp3625226
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:01:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5jddo92OpBf8j+mc8eU2pLt8sDu34U0byZ+kTfd+Avo=; b=pHaf9Ra4laNh6enx
 9OSeHRh3G456tKI/C/rSxL7+cWcnGcFz6F2xJmh+rmWdxYhQIHRcDpUs6I1sx2s1
 AWJLFn1FPWVNbdG8EfpGKI7XElXS82ukv8voOwNg63zrF2GkRjOje50nJz7O+0Kp
 U1QLc8kR4lp5rlsJUFkJyvyEjKaKOcD/zwZeUpCtRrEmzyLWUxSs1E3tO0EpxMts
 OoIVvFpg5XpeU7RrYv/4crg61jlLEezRTJV4n+QN7b+fR5PjlSUvlGBLFtYm6gQb
 vfJ1JOCOhx6nyN+fKCq5NYaTx5bl0KgEEjTY+yXqwPr0ZxfMpoomTakjOTIKfSh1
 lE8sSw==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com
 [209.85.222.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fdesa935q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 10:01:40 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id
 a1e0cc1a2514c-970cc72ccd4so931207241.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jul 2026 03:01:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784023299; x=1784628099; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5jddo92OpBf8j+mc8eU2pLt8sDu34U0byZ+kTfd+Avo=;
 b=j+Ih9YyKY9H8NCwMzcdLwzeaK38hubQOsMpzHsX+A/Fkw8xOURiIy+DPIHSwm/6q+O
 CQZ0D4xmKjjAMY946kew/A/JvSlY/kpoLl+0bPw+XR9WCvgf5QMqOqwO6rNQy1764twk
 wBEWyRyjVG+wzz+UoPTqTtadaQLf2uksigaw/f4xcU/VidAOx6/Tfda57btn37rBrcMm
 SVoqsG9djbmji4Nprx0RdQ8AKW1cS3ThZEGAHmGjJYeoI3yfVmZqqDchmWP7hW8r4i7f
 W4Vy+jkIySMYhphum4tGU93knyjUStlds7ZoqUkLEdH4uXLai9U27rAtiI6wi6ymweIY
 Lblg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784023299; x=1784628099;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=5jddo92OpBf8j+mc8eU2pLt8sDu34U0byZ+kTfd+Avo=;
 b=lC6RZUb+W0DHAqEbfTo/1HssiIEVVwyX+iq30hpVFdoWCdbYvpV8PJGasLqik+kux9
 a2MpCtjxxe/92u1Nv/fOQX6/W+vXeDT+VydOs7eRBsHcqV3HlGH24v6bTpxg964oQUGl
 533D6OL290uxxIid4CcH3+X2UF4DA0sjHD5AJAhHapdR0x+Q70imNKvDZF9AYIIFOJ10
 qWdpJ8KNp8JXA/bZiJMpX3o0VpBe4E3HysaAThkbj082361zw9nn0wBUDBrBwSNsjzbA
 4+JNm5FNV8crtMg8mG5O5oI9lR5Pvg89xjx4/QQHGzqu1JSjs5lmGr6yCb+RsKvaGhqV
 ZMOw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq8n4iAqlhjfio5TVo5E42Zx4Cv/xup7Rs1KzzXUDqSq96IW/UxZNMB7Zj8u19ffywRlFKhO2QZme2d@nongnu.org
X-Gm-Message-State: AOJu0YymDodyaHGxg13/IiIhhYtGsFnt+avEhTLqsDZLm3JOh84Le6H9
 XsK6BsQ/i77ytwtRazEJjXRY+uATwvWo0woojAZD2DxHy2796QUmrMR2jVKLTiZth8sgzGf+0m4
 DH0nFfZozmTiDPspupiFSNKb6sU1iYVGF9d2GICwmKtVz/BSCh1SkSSEB8+Vti1gH+w==
X-Gm-Gg: AfdE7clVMI9XLa40Z4tsp3jK2IQt8cZGiIEnisK7D3NSxZMxNdxXrua4SMoD/kJB1tQ
 bLxvWqg5jWOEKn8uxE43hOE0BpzQdUI2V7U4/BCBxpRaidrI+oSO718HJO/COYCWDGn9YgUNAdu
 VMz4IQZnY4hMhnQ2Ptsc781WKuxkJPZs/vAuqIAKVl7xvFbTJrB1Q0VS7b9tNbmZ4AhHnHw/ow1
 9T8loJtoi2PIcci9Wai40sKPEsVeqf5YBqcwbIM2/6C6C1Y2RloGDVn6PBVmicfapEKSWfT6Ols
 5ErsHespVEm+w4s3Dpae5d9RH5W1HgaZfKSaH6IP05Yupd0neuRc9BnXvrZpIamE1sf431oBhF/
 HU6NiSNbuRohR0qNihnuhhhL+ZiB1iOlnsL6DAaySV2AuGCgI3RTyKu3gnXBsUA==
X-Received: by 2002:a05:6102:620e:10b0:734:54fa:971d with SMTP id
 ada2fe7eead31-7450c7309f2mr6821696137.7.1784023299429; 
 Tue, 14 Jul 2026 03:01:39 -0700 (PDT)
X-Received: by 2002:a05:6102:620e:10b0:734:54fa:971d with SMTP id
 ada2fe7eead31-7450c7309f2mr6821665137.7.1784023298915; 
 Tue, 14 Jul 2026 03:01:38 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c1665727517sm74372066b.30.2026.07.14.03.01.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2026 03:01:38 -0700 (PDT)
Message-ID: <4d6a6a94-49d7-4a37-a590-bf2a3105b994@oss.qualcomm.com>
Date: Tue, 14 Jul 2026 12:01:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] hw/usb/xhci: reassert pending busy interrupts
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>, qemu-devel@nongnu.org
References: <20260713112004.4956-1-kirill@korins.ky>
 <20260713112004.4956-2-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713112004.4956-2-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE0MDEwNCBTYWx0ZWRfX/kylQxg5I3p0
 3VHmidLnA6dwo56rh5XIp/4gedg3KTa7UqYXN5I3EObI+H7RtCQrGS1Mztuw0b2S9SF8Q3pxOcQ
 wS1eXR0aGoh7NiK9K9Q4qixNtu/m6gk=
X-Proofpoint-GUID: 7g9LKxyN_6juhVG22wOuer_ws8cCVFyW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE0MDEwNCBTYWx0ZWRfX/7tVbsYtJ+RC
 Eimk6tGBD4m3fiy9/7k971i5L0KQ6kUj7M/X7YoO0u5hMDY5Z5Wrxmfj2hwasRIyOmwufEksS/Q
 jEpylQfKZ+jyV6oM22fO3EXDtzCvuFAWoAkwUcNHvwiVbiiE8CVyClnKzchbq9heF+28gd4bLZr
 caMN1lhKiMV6fxroH+FH0cvEjb8d8NLxP4G2MslBthTjnsz8liVarK1w05yTJu3P3LaIoqTqsnR
 FPkchBY3YRxtLyjyeuIyRuoff3sqMyzaHn4+RCIIw5qMQuKZpicg96FpaR3zEMLQ1NGMumo7TkZ
 GqUQ73PzofbdwMXA93cRm+4dDMW4GO8fcN+btTMlOwOrDiqYYw34HIi1q/tFq9zxJGUQ3Oo1KdK
 1H0xAF8TEGkJCcM294Szx75pdDESlVVGO7XlnO7/ub/KM+dkL4FX5p6f4nXMD9nc1jEGtkwTsnJ
 MuxZhIpC4c+mtAkOCAQ==
X-Authority-Analysis: v=2.4 cv=PZLPQChd c=1 sm=1 tr=0 ts=6a560904 cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=9AGnabIfYWIAb31H8yUA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: 7g9LKxyN_6juhVG22wOuer_ws8cCVFyW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-14_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607140104
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

Hi Kirill,

On 13/7/26 13:16, Kirill A. Korinsky wrote:
> xhci_intr_raise() returned early whenever ERDP.EHB was set; that also
> skipped IRQ assertion after the guest cleared IMAN.IP while leaving the
> event handler busy bit asserted.
> 
> Track the previous IMAN.IP state and suppress only duplicate raises;
> when ERDP.EHB remains set after IMAN.IP is cleared, assert the IRQ again
> so the guest can observe the pending event.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   hw/usb/hcd-xhci.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index 2cdab3ba0e..ce06d52c36 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -577,12 +577,13 @@ static void xhci_intr_update(XHCIState *xhci, int v)
>   static void xhci_intr_raise(XHCIState *xhci, int v)
>   {
>       bool pending = (xhci->intr[v].erdp_low & ERDP_EHB);
> +    bool was_raised = (xhci->intr[v].iman & IMAN_IP);

Per your description we are missing to clear ERDP_EHB?

@@ -592,6 +592,7 @@ static void xhci_intr_raise(XHCIState *xhci, int v)
      }
      if (xhci->intr_raise) {
          if (xhci->intr_raise(xhci, v, true)) {
+            xhci->intr[v].erdp_low &= ~ERDP_EHB;
              xhci->intr[v].iman &= ~IMAN_IP;
          }
      }

>   
>       xhci->intr[v].erdp_low |= ERDP_EHB;
>       xhci->intr[v].iman |= IMAN_IP;
>       xhci->usbsts |= USBSTS_EINT;
>   
> -    if (pending) {
> +    if (pending && was_raised) {
>           return;
>       }
>       if (!(xhci->intr[v].iman & IMAN_IE)) {


