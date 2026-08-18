Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61561C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 16:36:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwMnF-0002Q1-3e; Tue, 18 Aug 2026 12:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwMnC-0002ON-0l
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 12:36:03 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wwMn9-0004Tl-79
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 12:36:01 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IElwrP2157230
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:35:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5gnoh8s6T15KFAYjNxyhTmN9UtpuAi2Oi6es0VuHwZY=; b=LS9bjzvIjDz4EEzc
 8gBndRYOON2YUs55Gp26Wuvpjs7frN125keCNZszb8dxDqL6QChOL5yNynShk1wC
 BpMjBR8ITWMfeoaapZ0WNZHYc5TDERpWGLsDBlJMK2vm3rQnOJTJFWDT44+rX+gj
 oDq48kneQ6ICMTmKlB67ozh2nnQVsGGTL6Yw8r9u0nTfPPP1YRK5ribfEe/om2ue
 FiiPsKreWVBq95kyMGj9FkU/0mJ8V+K3Ef+vEiXbTrHFDnnTw5rqD9KiQP5A7bsD
 vjLM4WyJSZDI5wZByZHytI8Q3j26Iz9f/X2lntTUxQAVTPY4dZVset7qQSomWvoh
 n9K3tw==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4sfngjg0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 16:35:52 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb4bd11ddf8so6436691a12.3
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 09:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787070952; x=1787675752; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5gnoh8s6T15KFAYjNxyhTmN9UtpuAi2Oi6es0VuHwZY=;
 b=LsNEmtQEv+VM7iVT37fvspMrDlVnaXh/YltXv/eWSYqY78hoDp+fiSFx6xaqzMVkoc
 axfI17C6ymFDSg25eACOnG6dmaY4+BJICspKVYBcapT8hOmVeu7xqVgEAZtqfOLXalcQ
 U3TcUrYntmxPqC84H4QEHIdY+aZtUvEeBcpHQrPUAP2NZvTsv0DTY9wzQQMD6Gmbsjwy
 ET9Wc4wsNnTdgdVsSxdxUxifVg8bR23Xt2ORxr3Y/+j2a9Co16e4eM6UxnExM2ROZlPK
 Sj32jc3Z/RPuwYmke2ooCDYc4NROp+ymFvcsKFdYOrgFE4VYNwGB/KKYCOWt7vrOWGgv
 XRdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787070952; x=1787675752;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5gnoh8s6T15KFAYjNxyhTmN9UtpuAi2Oi6es0VuHwZY=;
 b=hqFOwEu3diQavUgNfma+X4fxRU8lj3KOy8tZIC+YXxIyGblt4PmJDEaxKhhzp/jW4V
 qT+zOmn9dcZQEoEcbfJsS0FRYuvNWoUI+MlLYoGZbWFvx+ZQk+ifNWfuNtx3LA1InQVD
 F5P0ZrPSVHrNo10gXX58H+s0XiN6B3AiJXlVF1JKTtqiwreSe/iu3+65P42Oy6mdftXs
 rMbGM6KLgd2G3XsC59/WgOSrY+Prxstz3mGlGMblqDstTW8ikSJsqQiJJgiQwXWGYOf8
 c4bijmwJPs9hQpsF64cWGklJFvrET1edDmIKL2wvCVSvmlmH4J7aJcJV1jgR9jGyM2BP
 lelg==
X-Forwarded-Encrypted: i=1;
 AHgh+RplXnKLy+lNCEntDF2P8B8zSL3FGgLJXBkp3+H09/dbNFGZR/zLj1veBFVTzP4Of6v7CjJ1ntzD3W+D@nongnu.org
X-Gm-Message-State: AOJu0YyV3+oeVX8EU+RZsEZE+Fry2o/yiXQI5p8laI1sUtnXzS13I6QK
 fdl8vQHUZznyzy1QNlomGsP53lYneRHBSUFbQh6ChvlVrKeJKiA7FnoOomfj+LaJ1S4ebWa0WCb
 XhUcLk+zXuTpnuxLhwNauMcLUDSw/sHdarlC4+7paq/Lj+fCed5PT+UCAOQ==
X-Gm-Gg: AR+sD12S0an40+3wsicNyWZN8517N4jrt0iL1gQTx1cYDpaoQIf8fa22Hyeik4pN0v6
 6NQD08xJUGNVpNtPoHcViRstb8gj2ZBRIeSAsfx5u+wOPCZUTjg6xRcPKEYY1m31JD5vSXb5H4u
 G7J0CAEo9d7enGXZIz4tI8rdN8SEjI3Ks2JgDLOP7qJRc4WEs+epGtq7bliSltLD7367u1BODzR
 vPB7BA0IIt0mXsvqdfbHvt5tPlJkuU3UY4Uid7Sd8bNA5LBIGakOKqtLvb2ic2YjzfSHIBAFwZj
 xmF4+WC8DjSnFW7nEVpM/8LWpk+c6EvYt4bsI40Bilyqca8pH9SqS5Re9EeLsSFgI6yjid71gdo
 7q/S1VtQlz4tv8zibfF10Anobjed6fJvGq4YYituMA72HMwOAw/MT3lmAzN58bwJY/EME
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id
 98e67ed59e1d1-3933b6e9788mr41442655a91.2.1787070951811; 
 Tue, 18 Aug 2026 09:35:51 -0700 (PDT)
X-Received: by 2002:a17:90b:3c02:b0:38d:dfd1:7a8 with SMTP id
 98e67ed59e1d1-3933b6e9788mr41442508a91.2.1787070951188; 
 Tue, 18 Aug 2026 09:35:51 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-14153064d86sm15934156c88.6.2026.08.18.09.35.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 09:35:42 -0700 (PDT)
Message-ID: <29fca8f4-9730-4090-8c89-813ba5c248fb@oss.qualcomm.com>
Date: Tue, 18 Aug 2026 09:35:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] hw/vfio: all vfio files can now be common files
To: Andreas Grapentin <gra@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, philmd@linaro.org, qemu-ppc@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Steffen Eiden <seiden@linux.ibm.com>
References: <20260318174733.1717643-1-pierrick.bouvier@linaro.org>
 <20260318174733.1717643-9-pierrick.bouvier@linaro.org>
 <aoPw6-MGBcTOfxwp@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <aoPw6-MGBcTOfxwp@li-d8547bcc-2d90-11b2-a85c-a70f2a37009a.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfX+g042ddmWiV0
 x2Ba04qppOa7oiL+N39ETjBoui5SF5HMLmTL53OMc2WCLfLRbU5SBVrj7OGV2AkJugY8AaZmkeO
 wdPbNAbZe4mBXhHjyc52l3/qBCAgcCo=
X-Authority-Analysis: v=2.4 cv=MpliLWae c=1 sm=1 tr=0 ts=6a8489e8 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=afTaoWqni5dwqT_SYqcA:9 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: sw09bTC9na-UinCyu_aOa6n_TbSPWG12
X-Proofpoint-GUID: sw09bTC9na-UinCyu_aOa6n_TbSPWG12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEyMiBTYWx0ZWRfX3w+aPLM+MUtB
 CWHahW67+nywrHBRNhB6WkTt6vJln4KP6rXGZaEjJWVhoJ1DMWsbgwm2in+GJBuUvvxRsfEPNHT
 PpNGLPhqDx/1Oenp6NU+Z8cCcJ7ocUzjtgma2ruB43qtZRwChFMTYOtdcstDVLNufQi5aT5ZJoh
 OCKlBjGRy33fJf11xaMOPXuEoMEToonq4Ni8KG7K0rMKyDAA8OuE0pmisHAt39aa/KGWwhVziIP
 RcMANC7GXAQX3Rf8/jQnJ7W1MRhXukQq9Ri65FBJ+91Gi2DoNchwUfevP9IrpKDCI2zFD2ogOYQ
 xEZjde59eRkLt4OvASMYOce5on8rPD0UTqZYc/wz6en5Aw8WbO0x6rpgrLIlCbCHHeCcPyDUMx+
 sdsLwOG0E4u5/MHn83fq/uT6w8gvijotKO1s1bcvxFV3CIgoEkjyHzm8BYD/HNC40LMw9LdutNm
 iccSw0nmoDxy+i57Xjg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 phishscore=0 adultscore=0 spamscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180122
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 8/17/2026 11:18 PM, Andreas Grapentin wrote:
> On Mar 18 26, Pierrick Bouvier wrote:
>> -specific_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
>> +system_ss.add_all(when: 'CONFIG_VFIO', if_true: vfio_ss)
> 
> Apologies for digging out this old thread, but parts of the vfio code
> need linux/kvm.h, which includes asm/kvm.h. Consequently it can only be
> fully architecture agnostic based on the assumption that KVM will only
> ever be able to support one guest architecture which must be the same as
> the host architecture.
> 
> On s390x, we are currently working on a KVM change that breaks this
> assumption:
> https://lore.kernel.org/all/20260812153631.3376090-1-seiden@linux.ibm.com/
> 
> We are in the process of working out what changes this would require on
> the qemu side, and will send a patch series soon for discussion, but
> we've noticed that this patch series in particular was a breaking change
> for us when moving to v11.1.
> 
> Fortunately, this series also extracted the architecture dependent code
> in VFIO into the kvm-helpers.c file, so for us the most obvious solution
> would be to keep kvm-helpers.c in specific_ss, while the rest of vfio
> can go to system_ss. Would that be acceptable?
>

Thanks for asking.

It would be better to keep it as system_ss, since bringing back
specific_ss will break the single-binary compilation.
It should not be needed to rely on target config within the C file
directly. At least, we didn't meet any situation where it was.
That said, there is nothing in CI (yet) that prevent such regression,
but I would appreciate if you could keep it as it is for now.

If you need to filter a specific function per config
(host/target/whatever), the right way is to isolate this in a new file,
and condition inclusion from build system instead.

system_ss.add_all(when: 'CONFIG_X', if_true: [newfile.c])
Also, you can add associated stubs for other configs in stub_ss.
stub_ss.add(files('newfile-stubs.c'))

I don't know the details of the series you sent (and too big for me to
take a look now), but if you have a precise question on a specific
patch, feel free to reach out to me by email.

> Thanks,
> Andreas
> 

Regards,
Pierrick

