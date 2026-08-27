Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 750BBC61DB9
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Aug 2026 09:02:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzVzf-0003UD-Uq; Thu, 27 Aug 2026 05:01:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVzc-0003Tg-H9
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:01:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wzVza-00039h-SF
 for qemu-devel@nongnu.org; Thu, 27 Aug 2026 05:01:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67R6RCYf2074836
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:01:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pSuki79WLItnMqjtwAVVl4J/Fjo8jJF9pvoQZKKkHog=; b=BRhKYcOLjcXb+xBJ
 lEdgOVn9O5x8JEL2wC2J8XF81qyodEtYcxtpAeMfjw5ICtWlz/pNikinuzhCuoMU
 jR8/cp+rcu5R0T9zP7mM351l5xSsDSvrlO+18SN3v/TmiN0LSl8zMX7pfycLbAgx
 R/bYonSTrmJzFa830L2fqqy2ew/GBTJCjG8EDtJxWxMujrT6yMtRWEB5SIlDGLfi
 Prcz7bBIZVnnwYP9VxX1OYRC3lwX770SSSgLpYK0D+Goe/aHBJHBfZdtJUCsCqdK
 Oz6nANqLJaSnZ+otXkgf1dyQubG0WpLJFMcAZq0wZ6+5IJiay574bfktAOLuERca
 c07a9w==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gaa3bhrj0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 09:01:49 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-52fa5c5a4a6so6073791cf.0
 for <qemu-devel@nongnu.org>; Thu, 27 Aug 2026 02:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787821309; x=1788426109; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pSuki79WLItnMqjtwAVVl4J/Fjo8jJF9pvoQZKKkHog=;
 b=QLNy/IG2fhCcnvp169wwG7TgE17PB35M+382AjMtNIi9D/p8bwXT1OhLB+swbx/6ad
 8eING1J2N9h4B8EvZG+LOGldBEyYzmVUSTobUmgI2lh0Of7e6RmSguX4MHgT7jWZAT5m
 nMlwnkKnIFnzhLAutSOpSMIyznNouCeCLAAvDUv+ZuHCZJM26CIaiRZN5hZiwkjJD0mi
 E0a6Q4AnE1S6K5pthqbk9qWYQmVJH/PMvJjTiWFp+db8n+3hahp95DElFej84ctPCJv+
 j6RTs+oUOOumZ6hBrtbs3eIy/35W3IdCAxui+EoId1bHmI8Un8AUGKRIIeGGLFMOPA6I
 UAFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787821309; x=1788426109;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pSuki79WLItnMqjtwAVVl4J/Fjo8jJF9pvoQZKKkHog=;
 b=qG26c93kDwtp8iGJyU5zhhujasLB2X2019sbgebIpBE2hvldMKsRCzWLIFv0DIqgsH
 9PqKoDjfrNW2dwUF+FMcwaDyl2LvM2Dp7sIeGg7VBpQ5FdWGI4dtnjn7Y+9xPibDI54A
 aK8HgSjZ9ZVuypImdN3EGKACIZalAUcBhdNWajcCabiRM1g+yjBo7mUJX3xgRknrUBc4
 O5aqVAybW2OZe+K+u5CovLOk1xgNwj4dtgk5nDufz/anIXzuXIzmbfDr1UhqF3xzTr51
 B326mFhHw9elNYovIAt86A9RCG1JiQlXuMWi7wYXpvD0oSenP7nFdSobqYwxmm2JlQyL
 Wsjg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp7BINGNXdbTvTz8HPZjD79P9rAxbMDT5TsgB6Cs0Vinbtlqg3ngPqz6zKwiZErS6OSD2G6vVWSy64q@nongnu.org
X-Gm-Message-State: AFuF++lxmAAPtQH7o62gab/iWVsaaaeS1l3Cw4m2lrUOZRME95OKe7AR
 OEZvdWRZb9HhE/Eu5ZvRZRq2toaJ4Hr7nCefh1YYon5BoR/bHhAIpMPGIj6hNt/WWmC5uFRdMUs
 QO8MbLzK8ufLZRYF0SK+NSCOG9+verYpUkhWBQP7SiW1HQ92iVxlmYNMBZQ==
X-Gm-Gg: AR+sD11A2fHz3y7uKM7HJNYALtwMN5FmmzWu4nBgIUz0RW0jzYu4yHpDbQjeWZ+9h80
 IjDGM4sxdKZFNGekHp1J1SCfv4afI7mBFHDLSORNfR67ru+HCBd5iSRv4wcJRWHeeRAoAXWBXBP
 DYTZPKLWZyD7k+8ZZ9fyglPge1r2sKM5vAYPI6/rbQ2CZPA8lFXGODkLd6RdjAlNqyBU9X2w2aW
 4mtaajerTrSV7nvXFRBnYfFw4ABDrymbA9SYUMNVCo09rJ0P4KDmXvxuFi6I2G/8Q3jye/SLfQw
 a6DTygGpmKn66T9eJ7pLtFRyZEfwqdRN8rm9yDCG6/AJV4b/1rkKBKjEA/pyASObDrLru6SZ7i/
 ze0IDoIS1yN3U2RVM0XGyHir+jigHOhOcF5+cpDnWT79CMz8C
X-Received: by 2002:a05:622a:5591:b0:52d:fdf9:aecd with SMTP id
 d75a77b69052e-52e42234b75mr155027371cf.3.1787821308716; 
 Thu, 27 Aug 2026 02:01:48 -0700 (PDT)
X-Received: by 2002:a05:622a:5591:b0:52d:fdf9:aecd with SMTP id
 d75a77b69052e-52e42234b75mr155026461cf.3.1787821308208; 
 Thu, 27 Aug 2026 02:01:48 -0700 (PDT)
Received: from [10.254.188.74] (164.170.88.92.rev.sfr.net. [92.88.170.164])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482e28dc3f5sm7679285f8f.21.2026.08.27.02.01.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 02:01:47 -0700 (PDT)
Message-ID: <9cead44f-c71b-4865-a1dd-c1343a39ed2f@oss.qualcomm.com>
Date: Thu, 27 Aug 2026 11:01:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] edk2: update build script
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 Igor Mammedov <imammedo@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260824164751.1700783-1-kraxel@redhat.com>
 <20260824164751.1700783-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824164751.1700783-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfX9B6B+6NNCcHn
 tTEze0Gqwwzr/68IBS/qf/jTVA1K9fgw7U0XOZEcgzCLmaiXO6x7FTaBYWCQvk89xeU0S5Bssw7
 EdOWFzkaAldrmXeUcd89r4+RLK+aObCdn3AEN5dJIuMMLbypCV8VYbjLn74mtLwJ/SckFaA/jGZ
 LlpfBsvzjK3Y7wxODwkpc+8vSFQqVF+SVHScn5fbGprDxq1NTU3cHqwMsKyzu4iFta5j3lHepDd
 FGmo4FASQpaR2IOoRGcQzY7JDCuq8O3o4QuRqFY5F5SeQTQr+8V0VJI/y5DXOmHBwavnmAOpJli
 8vUH858Zxg3JDtNdJ4U52+NM+vXFpA6uExfPbb2Y41H32go0IYJlMAH9eIM4WHMcef7uAG1QT4o
 KUaZZeEzZf9VH9/Y7VocLPsE7axNI+T9++bRMiw/TNUPGXMSfzG5gcD+ODA5UHo6g+DxDA6ZtWW
 JwKqatS4NewswPsPR7Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI3MDA3NCBTYWx0ZWRfXxi2RNiPB72Kh
 Gnovn+T/3nH+5VcPiQoGbO08ODXrltPuiMqvpGENxYXk57h2tS6BW88vw60MC5kcpxw/bp+qap1
 GAHjtck6fHXp1MDTqJE8GKZTcGPxub0=
X-Proofpoint-ORIG-GUID: wgzyazgNr0inQPtKgn6efKfxKW1QfEM1
X-Proofpoint-GUID: wgzyazgNr0inQPtKgn6efKfxKW1QfEM1
X-Authority-Analysis: v=2.4 cv=KbfidwYD c=1 sm=1 tr=0 ts=6a8ffcfd cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=T/Q9W4kDmp1FI4VDxy1skw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-27_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608270074
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

On 24/8/26 18:47, Gerd Hoffmann wrote:
> sync with https://gitlab.com/kraxel/edk2-build-config/
> 
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   roms/edk2-build.py | 21 +++++++++++++++++----
>   1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

