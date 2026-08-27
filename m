Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8921FC61DC4
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 22:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wziw7-0003ql-KU; Thu, 27 Aug 2026 18:51:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziw3-0003qC-NQ
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:51:03 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wziw2-0008MH-4d
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 18:51:03 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67RMdjgD1215585
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:51:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zSqXmmGO52LKPy+zDIzGfsXMDBn7E1gw+1GsgRIOGig=; b=M4ZAUBBjeDC0T2IJ
 8bA7YzTV0IZbZsX8gOOoIc6vdP5n3EdMChGRoJwGluJSYDIoSqNLZFsflZrcyHhb
 +X1iNfMmksXx2PTSgbgBTCf/SYUvQ/qrDOpcBvBY9PDShmxDkgL6bK5Zp8YePHPG
 oGM7swOc93/tdIb+c33AA77eAFXgdxrYHbC+OZ/zlN+odFeA79zBU1NqOyrFVIi+
 la2E9uX04qlsexi7odPCxTLGlEpOQEkjAo7M3ENwz8SnHO0oAyUiSxprrRhK/U21
 47v/xJC+wNKwyrSS+R9JfECYW2fI50t05+inSdW7EK2e3wCknFt4Xq+DoAaidcJs
 Cy9hiQ==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gam6fjqxh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 22:50:56 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-39640eebc57so964769a91.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 15:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787871056; x=1788475856; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zSqXmmGO52LKPy+zDIzGfsXMDBn7E1gw+1GsgRIOGig=;
 b=cJaL52yAq+tlIXirHGatpMnZg2KE2umRKteV4ug4OySem4dieRYV5BGC+EPROhCXui
 LV7SOuIVpOq63z1WM/j6QKFAuKHA1POAyVqNyh/86RGbfQnjP7Xxae3ErIR02tzvho6y
 +eQLlnS3YB/oMNDzaYkpbYcEpgqEBGAci/xL2/rdBdSWwcpNv2r8MZ7WBPGTBksrsZxA
 ZDOWl//qXMlzhTvhWTJnCxw1Cucpy1AXdszYqDpLUYVc9WKMqbqVfTyr0vYnkIuacUD0
 l+u52jXJ+ROHMfdhEhAw+wRHJdFKW9aA+BqG/vtobeDFi6VIcoq9+u4Qj4GTHIwFGkCt
 6cWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787871056; x=1788475856;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zSqXmmGO52LKPy+zDIzGfsXMDBn7E1gw+1GsgRIOGig=;
 b=eSZcvHpC4qabPexkyxWYSrSh4jYVedPDcdz8wQynXKSJyRGZXj1VHQ7KiHt+hrt/pH
 MrFCxBPZj2+s7kFMz1XEfSipfZkF52K3mjdOmMU6GoL1S5Pfvp4/RsI2/BtHEOy0Se12
 I9R6H+3qQ8BpejISoPoSDqA5Y0BTIX7/SnnNwTc3hfGIMDcEi2Pgc8tuH+fUCHALE4H6
 bJ3a+YtZRHoOymiGyFu5+kpY9RTxZSqk2c1mmGHQ+jfoTgo7yE9xrxyyoTajeSF5YEqV
 E8wBwBWQSRqaonz8zr6DD1Tm/vGRSGfbeUIkCq9XWmnbIeG3dcBOoatVDhy33gCzfoil
 p4Dg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr6241YdNaO4JyF6fWQNvQJNX63v7V30k+AvXR9qLoFvo6nRZ2UuJU4VrxXkex++ByJD0/B3MSuqsKM@nongnu.org
X-Gm-Message-State: AFuF++mBXAJU83g/Bg3fLYRIE/2zoY9dLFmyKLiQ6CzGr8ivU0W87fkW
 XOfkVIHnB/N8AULP0nwtDLQjH0g8P/NeXkpSxPI4/4nsIMs8yYnOxDrhTj8Rmsceccqzh3apGN/
 3Q4iC10Iq/PeiQeM48da5FPsr9O0ZBPsVl7j95OBi0SJrYUPLrlDyOhKLDg==
X-Gm-Gg: AR+sD13eKPpYGqjnbi/pQ3uzkSswcXXo3bboEAFRzRMd/XFRCTzvzZdUnXhla7Il8JF
 4UPNrMKE4+zQZEI8q136OiLjla/mdcx8gx46jGbiJMrSh+tH3mSf8Bx6/+TyQyEeag9LkyZ14tI
 D+rNzFQfkQxmKshgp0s2QxdM7m+ENpqSmP3tFKAuBREaW8Mx1r4NBht9YhnlGbRE1POrI8zlkOd
 i+nA3Q1+gGUHbJ3zH4pVzLxgPV2E9vzUt6P91Q0zScsMbwa/N0Ny2iJ1dTcMTQHDkAPgJ2gnz7G
 pkV4HE39gLHfDphUilIXKAk7M1ddWQaKhKrneQyRdNIg2AJvoAibr0QT53qJmCThPxesCG2oS8R
 i5G9b8DxAjkAfOhVKFhyMeaneCqhEic3LpHU/HSz8K4WKFpSv6bTMPGSZ6brtz5MHIL7j
X-Received: by 2002:a17:90b:51d2:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-396d0f8ffdamr4945972a91.9.1787871055772; 
 Thu, 27 Aug 2026 15:50:55 -0700 (PDT)
X-Received: by 2002:a17:90b:51d2:b0:38f:26c7:165e with SMTP id
 98e67ed59e1d1-396d0f8ffdamr4945900a91.9.1787871055297; 
 Thu, 27 Aug 2026 15:50:55 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3283d60b539sm20907481eec.1.2026.08.27.15.50.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 15:50:54 -0700 (PDT)
Message-ID: <b3609e37-cd97-4f7e-8d84-9b6e2feeced5@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 15:50:53 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/6] target/arm: Move -cpu max stuff out of cpu32.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, philmd@oss.qualcomm.com
References: <20260827041557.775080-1-richard.henderson@linaro.org>
 <20260827041557.775080-2-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260827041557.775080-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDE5MiBTYWx0ZWRfX3sjpWTimzkaj
 KF6ID5jOXfziFh2SYjp6ZAGmzN8IS06tkUFKn3eQ6zk+31KF/zF/bQ+ukEsBy/F3tMM1rG+gWCJ
 ALzvfJayMTqr/ox5SNucnrpv0Oq1mkA=
X-Proofpoint-GUID: EZEv7eGkrUpn1cw-HRBJbRR6AWtta1Qu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDE5MiBTYWx0ZWRfXwC3rgWN1dlgu
 aLFFnUOWR0p8mOyMA94+BkwnfJfONV8K4DvswHSLcV5KODlbpWn7L9BgCMYleXMUMHUa1rw1B+s
 1B793slSzy994HVE+YZ7r4krzvavMsGQ3gad24nkGKiod58XimzUxoM3bdvM2Q4y9R4mmcxRwEh
 ctsqmrDciv2EV9RFMoa0AsdAMUObNvNM3gzLIC2S2fr/1dfzoAYqrAvxw7ClDRuoH4kxQqwLS/y
 CI3ssk9+vM/PHucOZJBUTJ56LDsU4TmYSlcCCpLCVu1y3bzX2FruOOubpmYl5wlwS6hy0YD5dM2
 nyRCPb1IotxTFxCrHQ9RyehX3uD2eLfQKO/3130rPSe4G0Xu18brbwEyFvJYpKu6WbYvmJI9PLr
 Hh00yb4vnZSNC6+42iXOrmQbvT0CDlbf48EvAaLFvkINxY4DYbwbG/dNZnOiRwR+FG/CbeWG/v9
 Tk4Kqt4B8vyRGtW2jJQ==
X-Authority-Analysis: v=2.4 cv=eIgjSnp1 c=1 sm=1 tr=0 ts=6a90bf50 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=CQGHVcWclJPO4PMvv7cA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: EZEv7eGkrUpn1cw-HRBJbRR6AWtta1Qu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_09,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 impostorscore=0 malwarescore=0
 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608270192
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 8/26/2026 9:15 PM, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/cpu-max-v8.c | 117 ++++++++++++++++++++++++++++++++++++
>  target/arm/tcg/cpu32.c      | 111 ----------------------------------
>  target/arm/tcg/meson.build  |   1 +
>  3 files changed, 118 insertions(+), 111 deletions(-)
>  create mode 100644 target/arm/tcg/cpu-max-v8.c
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

