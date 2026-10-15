Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6963CC6B33
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 18:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPkf-00027u-In; Thu, 15 Oct 2026 14:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPke-00027k-Ht
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:00:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPkc-0000T5-RT
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 14:00:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFDQCW4126369
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:00:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 q4pJixTr9uopAemRu5w9j2nOLRQXk/pWVqYdvhQi9Is=; b=k1uKoi9rlpcQhJDp
 HPE7KlxUEnLC4qemT0vRtXwDEfOgslYw991troufYIASKVuEp8iKhAUmoNamh74Q
 7aAQikptnEVYqh4V4KrD9CtAtkCZGaP1fTVvY8VIJK57AQTnaJuB7jlMmY2jLVHL
 YqcGSKw0xoG6yK4dAYrcKD7iW+3WrdCLCRB2IP6UfvNR8PDFcNojotNlIBNppPyR
 FR0YEINtv1nmwbXLm/3dlSzhLZdjRAN3kk+dI/firv1Rhif5qST9O/ipniTNXZsM
 sfuOIROBk+96jH8l4FR4ZxjcnSnosdrhJR8KiBlE06+uLDJT/LHIBnvpV/5OZTMt
 h23Ocw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb19m0ntj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 18:00:21 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-17188d538c7so9970204c88.0
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 11:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792087220; x=1792692020; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=q4pJixTr9uopAemRu5w9j2nOLRQXk/pWVqYdvhQi9Is=;
 b=dx4AsauVWnxFNIPJSVGnAY5k5xB2NNib6f6Pqv2DgJiUwcSeJtaiJOGoSLX881iWey
 2EyZeELA9yx09n3ELEumWVa5PMKMmT0xZCyj529XloeSDqYut69EScnyB7FcF7/v4/xT
 o33fhmyGA9RlFG5gz3cFYAwK1i9XK/GCAxdXNjQk8I/SplL8iTIhJJ4wlkDUVkZpbt4q
 FnYE/QAf1dxf/ANyury+PxNPKDQm5wPyb0bBlFuR3qRbeLodrORS1Ej3RNNftv4EAZYp
 SceA1XotCICJIDPZWk09g3/ztcRaOz4grJ/DPWl8aNa8w3owcEz+ctbIMSc3gOB3gFQk
 YxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792087220; x=1792692020;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=q4pJixTr9uopAemRu5w9j2nOLRQXk/pWVqYdvhQi9Is=;
 b=kLcDJw7LQ9tHakVbyEWb9uqzfUUo2cvVDwEfVgIGUo2SF65A2/3XBCuOhDzS5mNUeb
 iOxHGji3DylpRNoM4KbCR/DGPPu+vdc1Vjdrc1zRrAzdfk1nw5rmVmkNSqOZ7ipSl1Pr
 py94g4G/r9XBtRJjTHAGSQvtXHAEA87bnq6xol+Dsb3KqOPFosEnvlTDhvBwCJHiHbZh
 WYlyycoeUK4MqymjgzVX2T92R2XLi3Ai7eSyyfI4Kbu2jWyvVfm6wAgyMGvPnCo3mSBA
 Xsf5Smrmsbta8eNSYOLJUO8YQWiOPFY+yeTh6WH9cbZyq0FYgbTlZVcWxNxJaylMQxjW
 T5Og==
X-Forwarded-Encrypted: i=1;
 AKwUvBxVE5GXgYal+Wznh0d0NWx6NgYjt8vvulwHa+zMINlL1dJPiuszvi53QTgITpdMluSpLsO6mxmChw86@nongnu.org
X-Gm-Message-State: AFq9FYKqsxnUxqatAD6NXYq8a5RWfpPRN6nU20N6Z13DCD/3otNaMvmc
 BoHpYnRxCtqM0vxSfCVqnfAS4tvCNApGPFnDpAQy/+aH7vdSUmNfbC4PuiWnPKIKOpiqwgiTzy2
 xAegLDGXzBL5YGtErjBke63T5zTYPSr8Bs8veKKnX0wLj3CFzv1ZPYQW7tQ==
X-Gm-Gg: AYBFou1CVfX6O4j8pT802jdT2lwC0joBJItxIpdU0CEFj3IydWCJnEkTU7QVNbb5KgJ
 KNru4ZFLU2YSwYQD1knl+j0qI30jsz7mcx+sXPtckaFOVEm9uYKPnmg3Ln0xxwbqB35SW3Ot1wk
 Ja5VidLnfe4NgSn+wNgn+RlVi+QZbARUHZSKznT99Emi6U9qv8X+aTxtem46TRXZr2a9xADOIO9
 mywbhQNiBu869wIS+6znL6vQE80pdxsoMnu07daFr46J8KtpDvs/E2rdDc4FINCeyohjAqv+dp6
 Pjb04De6p+H7eEYhmd1hpfgdY1f8mUyWyTamA2Di7/zHgf9+3uMAf+lsx/9F4LG4rN51kKeLuoO
 ArWpfGKnAZCkX023GcGqHlPIT5wiwikPxyvKnyqGH9P4Zg08R4/vdq8y2pH7SHITHtZAaKg==
X-Received: by 2002:a05:7022:b043:20b0:168:3243:c90c with SMTP id
 a92af1059eb24-17b74544aa7mr11412457c88.15.1792087219871; 
 Thu, 15 Oct 2026 11:00:19 -0700 (PDT)
X-Received: by 2002:a05:7022:b043:20b0:168:3243:c90c with SMTP id
 a92af1059eb24-17b74544aa7mr11412326c88.15.1792087218544; 
 Thu, 15 Oct 2026 11:00:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-182a699072csm565012c88.11.2026.10.15.11.00.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 11:00:17 -0700 (PDT)
Message-ID: <c77789d4-47a6-4309-9c26-97f49908dae9@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 11:00:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: implement SSR.SS single-step
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261015035117.4130988-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015035117.4130988-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=aLdlOr9m c=1 sm=1 tr=0 ts=6ad114b5 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=eAMg5sL7N2o9o_FCh24A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-ORIG-GUID: ISU0rOW50yK8JSE5ersw736bhdh_Fi4e
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA3MSBTYWx0ZWRfX601z8v64nKp/
 ic2AtHWHXowMW/bqq9VMdGQQTEniuK+AXEr7VRh4ogqYzq5k994UDixdmhzk9pqeRbr3N8K7lxd
 Zg/f9RK6meW3k33SZbH9SfXtTqQNiqA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA3MSBTYWx0ZWRfXygfpkzslIdEk
 vF+ndU2UbmCx6MYXqHrQ3J2gIvyehfMMqJ9h+CB1ASDkLOXWh5iKXYL45mfjGFJ6nQgHTsJAyE8
 CpATU5GYldIiErCOSA6s91g2K5jyBEgGKgn3N7F4JM2kVwyH6JoovwBjmpToRlgWmrwO0OLv15p
 sUyPPDUN3It/qAhX2CQ3rVhZbcjwSlUxZBXa0ZxMBvUdatZAScnRh8OlcXOYMltjgtYh+PiAhpt
 r8yv3FDcYHDxIumokay3tNN9RLwC4U7KONWC5yR5qxayBrsLObL0QIzgLPLyHzO8H62L0zzFCAI
 9aiE0yGBGCoTeuGy2/Z7IPNG4a6fUgNb5iSf70lEEF9J/Htd9RTEABm09bxZutayOr/m1/kyxQv
 zEKdqQloadJgP7gZKDgukP3gG6EH4RX3qblu9BtHsUfRSijHLmsuWdPaFZNg423fTMUjJ5/BRF7
 qbyQ6f8fzA7bUyu1sKg==
X-Proofpoint-GUID: ISU0rOW50yK8JSE5ersw736bhdh_Fi4e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 clxscore=1015 malwarescore=0 adultscore=0
 suspectscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610150071
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/14/2026 8:51 PM, Brian Cain wrote:
> SSR.SS enables a single-step debug event after each packet executed in
> user or guest mode.
> 
> Carry the state in a new SS_ACTIVE TB flag.  When it is set, translate
> one packet per TB and raise HEX_EVENT_DEBUG w/PC at the next packet (which
> becomes ELR).
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/cpu.h                      |  1 +
>  target/hexagon/translate.h                |  1 +
>  target/hexagon/cpu.c                      |  4 ++
>  target/hexagon/hexswi.c                   |  1 -
>  target/hexagon/translate.c                | 49 +++++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  3 ++
>  6 files changed, 58 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

