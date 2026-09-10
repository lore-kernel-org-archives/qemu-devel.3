Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA11C88E41
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2026 01:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4pry-00014f-8G; Thu, 10 Sep 2026 21:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4oT2-0002Ya-PC
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:46:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marco.liebel@oss.qualcomm.com>)
 id 1x4oSu-0008EC-GL
 for qemu-devel@nongnu.org; Thu, 10 Sep 2026 19:46:03 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ALTtQR2033108
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 23:45:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 SNJlwgJNvsbdtPopxDdGqz/bP+G2/cXsEm6PR8ACFPQ=; b=Wrgy3uQF42x157Vq
 9uBv4Up2wXhULegXNrYQEu1FLAPun50gvKlBu9RIG2v+g5mOTSS1DrQIMc/hEEPt
 xxBMN6+p52la7xret2DE9wv0178R2N9hgcmGgQzhrqHisY1Rxnbbq6e0/FV7sQFW
 4Uyt1Nx0+Rohg6j1l5+jYn9GqKuIB8SOGrat0kTZW7TcWs+UZAESYIFDuTqhOI4A
 g8mj927ySNpFZfu2gz/ocrd5QKzNHk+vngXyGglfUB1nueQtjv/FPde225tHW56e
 Y+pVRIXfFqNg1krdnlgZ0U/ujAe18JJT+5q0ZTK8p9QYdPHj+q9sYQ79AMBMrViq
 Bf+FXQ==
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gm1k29296-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 23:45:59 +0000 (GMT)
Received: by mail-ot1-f72.google.com with SMTP id
 46e09a7af769-7e9e2db9914so1918518a34.1
 for <qemu-devel@nongnu.org>; Thu, 10 Sep 2026 16:45:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789083958; cv=none;
 d=google.com; s=arc-20260327;
 b=KkmNx5T4M1aG3jx3VX0XABblIUIon2O1JhUNBp2F8Sx+i8yXylzSjNPntK4SKBJ/Bz
 1UIqjgLGp+oXrW0U1ReFbDMcbhRmzfSLzEhMPsNvtbcLOJyn1OCuzCT+vlOHfGTESyT6
 KRIZR7Fsa91K5ldUVSYEAyvhh5egoU2N5mI+YUGL4HXuKjfXNRG7Rn9QKcMmhxHSuDET
 CE8twqWnwxiPRhF0sLKSCRLHsFvuqCgN4inXlB4w8CPxmjmvystzmwBkigSFZMyIJ246
 jk7AyTbvhyt/6Ex4uxBn5sHnviuLmFmVk5h/T9jHqWGiDscvJilC2Brj3T5WI6rbLY61
 TbwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=SNJlwgJNvsbdtPopxDdGqz/bP+G2/cXsEm6PR8ACFPQ=;
 fh=qg98UZd52pNVEuj/ZQwsxHLtQgNBn3+BQsxmg45i5+I=;
 b=BilJKagMsI201ClmPwOVn/Dhcw/oZxnwCbxCYM5rNVa/kKeRGNo/ZUDXOa445Z39G9
 tGsJxnigRPaqstbrcZZiclV1SViwk80mVgN7+f+Eo2Ws2dhjUn35jOkja3jZKD3UyZKJ
 ayIm0IQ1EHEYsBAuUIGtL578WtYqcaVVlK99YlcGZI1k2r12QurMSId6PwxNtHuAtm2F
 jS1cmjgOSiPEUvW/zSVxCzDKcZR93b3lzrXEc+KPcqTHVOId9aQkoDlSklZfOMjPwSnk
 kR0XlJuJ5S4MnoXW8G0RAtYvm9n374uwW1dFbuDmuDIa0XdmmG2y9+4bkfYbkHjhghDK
 InvA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789083958; x=1789688758; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=SNJlwgJNvsbdtPopxDdGqz/bP+G2/cXsEm6PR8ACFPQ=;
 b=D6W2Oxz7rvXKEBYQ3wnylQ9DL70Mye+GX8Oq9EpD7yd+/A5+dIyGg0Z26ZpYYuMHEQ
 9kGtjbJ5aOSXnR7f2XXlMhq+D+aysWDA8fDg8YesA7ijchzAwD1gnysHt2i+Kx0haSkO
 djZTFnZLAvLdJ0eF3z9LyOl5WDtsSMV6kWROJinNFzT2fXn24m4zQn1FuzJvHKDnJnoJ
 M8pp8cLPpYku0wLehSdYq9/nARpo1LMkCDgwpYGbFBL2tqGvfJYv9X3VW41RlYOJg/Co
 ID+zg/MAmjbwsy4esboVi2BAO+ZDXLg3QiFtyYmnt9bF/6uN26A6Tm+evF1KIREaj71/
 zT+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789083958; x=1789688758;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SNJlwgJNvsbdtPopxDdGqz/bP+G2/cXsEm6PR8ACFPQ=;
 b=HdTRgoJzyErpRICOfpPl4kX6Sn6/u0ux2ZhcE74WVOLkomn+J0FZ7zAb8z1AMRlkgn
 5SMnVH0f0wOugaWzyvvlRM9fw9GCi3gQApaWrtaY504IuF6HHwYhUmNjrfMVagOotgIO
 2H0pmSmEG6M1TdIBqKLzcM7bG4dKfzmclH6RAF4sM8lmAxK6vfVj0SEvlOeD+Cq73TE4
 5UQgZai1VCVqNzp0tpZuclWIPwQrng4Ua/5Kotcl+3Ra+3XED4CKlX9TbZJOCiAd3t6o
 ZYm+KjFNPn+IPP4okcmXDKJ+BVwbVRB6CmwGBgmn0GLdxskAopw9P1zz/HSWX/FTTyKr
 5IwA==
X-Gm-Message-State: AFuF++mc9WQWdSe5sJqkgiY5I8fpRQ3QUCSlOdtByul4swbpgo2vUUoQ
 Q2luqu3bDb9tTbZute5cjj04YD95oGeSRaT9irW0R0/7BzMNNVlyNycaOGqZjxs3O87DkbuKqwE
 kST76AZqhDvzwE3ooy4M9AOIM5SAhm2kp5/oW/2JStmeanRctIA/jSnzf5q0gwGziXCCEOgFLn2
 sJFHskUCCH15Ekh+Ex06p3MBYebvvuFCqX
X-Gm-Gg: AYBFou1tBfFCYGgYBVm/Xm2sjBEkk/rk+v7WYueS48d+OsuJtM4TCKL0DMStNNG/xDJ
 sHH1Ei5XGxom8oVR7Ovl985L+XNCB8//APPkFEXARFKtNiA0i7xaWF26DtnXCrk3qnt8hFSfnDk
 Wbdbr1TVKzcbXUwdjsb2qpRXNG5hx9EZBVqTOrIsFUqFNsnfSCyrB5wibJZOpc2cnleWh2X2gJ4
 QADi/fmsmYer6bbqg==
X-Received: by 2002:a4a:edcb:0:b0:6b1:7e2b:dc01 with SMTP id
 006d021491bc7-6bf44465e83mr3304617eaf.11.1789083958280; 
 Thu, 10 Sep 2026 16:45:58 -0700 (PDT)
X-Received: by 2002:a4a:edcb:0:b0:6b1:7e2b:dc01 with SMTP id
 006d021491bc7-6bf44465e83mr3304600eaf.11.1789083957811; Thu, 10 Sep 2026
 16:45:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260910153221.1674285-1-brian.cain@oss.qualcomm.com>
 <20260910153221.1674285-10-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260910153221.1674285-10-brian.cain@oss.qualcomm.com>
From: Marco Liebel <marco.liebel@oss.qualcomm.com>
Date: Thu, 10 Sep 2026 18:45:46 -0500
X-Gm-Features: AcwNN1W06y2PJVX4xxr81ymU3MjpUhNy2XxbIVOglftuOfM_Bls2G9Jdlilkv7A
Message-ID: <CAJ+KCYNu_xstbpBRxGEUijvi9XvzYfRmARMsfNYYymvRBiz2Gg@mail.gmail.com>
Subject: Re: [PATCH 9/9] tests/functional/hexagon: add test_hvx_context arch
 test
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>,
 Helge Deller <deller@gmx.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=cM11IVeN c=1 sm=1 tr=0 ts=6aa34137 cx=c_pps
 a=+3WqYijBVYhDct2f5Fivkw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8 a=JlpliNfGtCjX0S38WOYA:9
 a=QEXdDO2ut3YA:10 a=eYe2g0i6gJ5uXG_o6N4q:22
X-Proofpoint-GUID: FG7u-x-nOt0mrqem-6FcfqAzWA-laSVK
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDI5OSBTYWx0ZWRfX2pqIUNLbXj4C
 wTsp88tEyhdOPgQEyxMTX7OYgbPllhtZmonDn4KpjfHeXBlBA02Mg/THnNEYoOGXkkFKuX93Zrp
 /rGLCWXuNrX+3I2TDMbekBewO0Men3Q=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDI5OSBTYWx0ZWRfXyCAC+NtRggD4
 ww3O7Aewbyp7cyYjxoozF0tVOSROqmhBb959hjV36ucYly7uvazvOCCOoHIe3ihmrPRh5UJ8cjE
 j+6eI7UMJvwmxy99FoNQRcGCdy1nEDBBeYWl77Kyov/XiR9tkpELXPWmptYr4B4efNhhxPr30Tz
 kEiVn0M2TfkeTz0+lhDJFhCtb0lOE8ayl8cV0lFvnltFo6O1eEaj7yU7LXo38sWSMhRPrx4W0xI
 S+mJ4pyca/NocYjx/LkVwL1+gZb5VQ0X/GjJF6OOtgPUNFPVttSi5lALbSBXyOj63eVQiYwK0Z8
 hPh2fPE70JsEDi9PMX3yxykBQvY65nl/PfdTEpaR3q3pBiP6JGI/ntLex1hQ+UyJqoP7nXbl7Sa
 izWoLo2PJuqHHLgUOGKxv7+QDTBmVwIoXXGkxoyHP8P1bfUGZrIjUixKfxIH82IDMaD3XU0sOnT
 WVrsNd+zXaK0eEPldUg==
X-Proofpoint-ORIG-GUID: FG7u-x-nOt0mrqem-6FcfqAzWA-laSVK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_07,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100299
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=marco.liebel@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On Thu, Sep 10, 2026 at 10:32=E2=80=AFAM Brian Cain <brian.cain@oss.qualcom=
m.com> wrote:
>
> Passes now that HVX raises NO_COPROC_ENABLE when SSR:XE is clear.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/functional/hexagon/test_arch_tests.py | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Marco Liebel <marco.liebel@oss.qualcomm.com>

