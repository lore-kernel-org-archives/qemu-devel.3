Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09F82C624D7
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 19:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2DF9-0001qu-3q; Thu, 03 Sep 2026 15:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DF7-0001m6-GI
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2DF5-0004Rk-Qp
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 15:37:01 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683IDIgR1257104
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 19:36:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aPNBDdEx8c8eJTqs/cXP0kYbK/MSZbQdUJcNoeD0TOc=; b=IE3+IAMoYFjge1ii
 hEWHWITV7tettjadLsFnFc9j+otnqd10IMn2PKA4qCJXBACB5PIJ7+R5eWPA1DNM
 FBlOR/EJbo7anrDye+Jan9mR3gpaFk1noJvGfACINTAvjGEzqQ9xNnhmQw32t6eW
 nL5PQJZSPAUwgzmy2jDh2aMkhrl3Dn4+uX/UledWPWubvu8f2PBggpRrAcucNqmA
 e1wytF93MSyvGAgdfTLowRvLVoJqPCgaRzPnYlMkAQPgwy7bm5QFqnI1nRrAz9QW
 mhYlnWq9h2SyJTRxX+dU7Zc0NumI0S02gpPu5SlB8sg2fFyBCJAiaSFFS4H3n4wd
 Mx3JTQ==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gfdyxgbw5-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 19:36:58 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-38dbf293831so346460a91.3
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 12:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788464218; x=1789069018; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=aPNBDdEx8c8eJTqs/cXP0kYbK/MSZbQdUJcNoeD0TOc=;
 b=IGPe889jSNkfy1/dJp7h5WYYmjzUCWebl/rkfbF78kPCBCOoFCgboW26SVa9d7VVPo
 QVlVs3S4pxsmZN/oTwjxJtQ0QkS8zfX9thK+mU+08D8Fa5gUMjp4on6WGLDRCBSrJMvu
 kjm3rkgIPAx+nt9eqirI6Y+MMkJUZC6mwkIHS1tFrOsN70EFL1zyhraxGTgsO+t9jMbh
 6+JUUFfPetPzj+h4UZTw6Ii7YWHF18m0ipQ6FbAFQznSPN1gyEwt6gpY4J76kCcpwJbY
 JwAM+ax2Tsa57uTYKUX19EgiWOINUmI5Dfkfb9M5ZNltmM+j2aq4nV6lXead3449QmAH
 4XhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788464218; x=1789069018;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aPNBDdEx8c8eJTqs/cXP0kYbK/MSZbQdUJcNoeD0TOc=;
 b=YvkZ58/Lk8adCUlNFafdfTkO/nIIXhKGtp7zgCUgeeMGVXjs5q7pjgqxjSxllsPAcm
 rJt6WfuQUGyEep75BIVJjNm2WSV3eyTAgYwYln+MD+nQvauVxZh0PXcIZsR5nzfE2CR6
 i6ts6BHOw0iAUBAE8wE2AdqRrReR6ozEHNMEMpVdK3Hsg/+0mIRpWCa2drVXRjUK54R5
 iN3MV/E/a6l+QQEputVER4rClhODzT0ix6CWlAPwCpjbA2WOwJJ3p+Ymw/cqB+/J+NV8
 wwyUhUWkOVc1JTJeXqwX5J8JSFg/Q0l+382ILq1a36A5+MoDf52C6lpfgXQgRJVN3mut
 vqcw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxSiPrpYLohmPDfXOdnD+VTYBgXNbAxxs3xwxFiCyf3jVlspQvsYJAmc9sI1Bve8YilbjntCHhWmvuq@nongnu.org
X-Gm-Message-State: AFuF++nCqQbKfw316/EH/+vT1Vxd4340GxMgjJzcP6Octpb7OD85BMoq
 GTcZ2hbT6dyWY/PYEq8IKLyJUvaqv0Qp2ONmtk33W5KNKTCGyXIrd95cG0KSIfPUQI+SfSJ90fQ
 i+miVoHN6Kc7e+vqy6HMURgNvyriTLeG2HRn7htRDvIbq43U42rP5AnqiVw==
X-Gm-Gg: AYBFou2U7P7Eu6pBQwcdTMDiVIzUWA92XXfuStqMtrJTGw5YOUk+CR3tXuwqmFEIuUm
 SUJHL0l0OhUdTKkK09j+DpUNHlrWUcDET797vg96kFU/qsX5gd1bE6DYZ9t5ilYa8X0j6buoeSQ
 OAxnW9EFAIVlrGsZbRlLP+uv7Ifk1V/e3wuwjyBuhNFSMf9xIbgQ6UwpBtx4z0C66tD5zLUxivA
 ABTTNd+cQ8Ot7E+JVafEWGBfzcR86icReXyZb4i5YxpXfswkG5llw0VtsErpun7vDxzwUzwAyuw
 4Y1H6L4NDoz7Z+AVrZOuDFrBETnrZu6O92kdYqTw31fLdciXty5ifVhU5c8IHLgn3ekGlLpakPk
 I9APvoOyCl1/JnviMvsRAvMdTZcxuEd2SYGmBJ+fROdjUQrwn++GyljPc9k+L0hAgkQJ8
X-Received: by 2002:a17:90a:e703:b0:398:d843:cad9 with SMTP id
 98e67ed59e1d1-39b26226de8mr1262988a91.19.1788464217877; 
 Thu, 03 Sep 2026 12:36:57 -0700 (PDT)
X-Received: by 2002:a17:90a:e703:b0:398:d843:cad9 with SMTP id
 98e67ed59e1d1-39b26226de8mr1262921a91.19.1788464217420; 
 Thu, 03 Sep 2026 12:36:57 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339bdf26c5sm942981eec.27.2026.09.03.12.36.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 12:36:57 -0700 (PDT)
Message-ID: <a00f97de-de13-4b6a-a096-704ea7446e10@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 12:36:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/8] target/hexagon: kick vCPU when re-asserting interrupts
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260903185622.3234171-1-brian.cain@oss.qualcomm.com>
 <20260903185622.3234171-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260903185622.3234171-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: 7tidL8uc1wgfRx5OdupVkFqoTGuWaWbg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfX/yRNkFFAZlnM
 dLJnATTyrjN28xp1eOckUv3MFFCcfhb5Ft25pbPFFBo77SgMrRKw5XILFr5/TYh7YI/v+tGeb/x
 2Y5CItsi8ZGwZ5+nnY4e0738NJEmfyI=
X-Proofpoint-GUID: 7tidL8uc1wgfRx5OdupVkFqoTGuWaWbg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE3MCBTYWx0ZWRfXw4zF2sAziL9g
 rQaNdlvo2yqypNNjB+Z4BbmHg/zueFsQg+QUOd+cxW4JBq1UIed6WfjPbT47U6YT1WZNTyh6RGY
 D8md7BJy62U8X4NDOd6XJ31kbWlz55vh7/2lIasS2lL6xODuIvOP2I1nryxLrgav4YCs6Mto85a
 YrQ9CdSMneQRcn+GBB5r+RIIptMSkj+R1eqKcVYC+t+O2DHrHwu9fDL8xy7oWyCHQDN89NQStV0
 iOJq6OpR+a4es0UAjWdOUIjpuTrulkuWf6HX6gR8wB6BxjN303MlWXIzYeZpS0NFuikXc92no/9
 6XeLkqU2NcMWBY+pGRR+fBNIPXKnL6sC4P3OhPWXBGe9FUhtVwcv6k/nHzx0H5GSGChg3rsOLLR
 K28EY163VtNVnQN1AfiDFAklf3lbvkU0bjpGBgWiDgHYERO6SqxXeYn3aivEJmizkMRF7vB8O/Q
 Ch5atPf8w7ejL84JYoQ==
X-Authority-Analysis: v=2.4 cv=X9Zi7mTe c=1 sm=1 tr=0 ts=6a99cc5a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=b6kYv1u0gy0l810oL3gA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030170
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 9/3/2026 11:56 AM, Brian Cain wrote:
> hex_interrupt_update() used cpu_resume() to make a halted vCPU notice a
> newly pending interrupt.  cpu_resume() is meant for a vCPU stopped by the
> vm-state machinery: besides kicking the thread it clears cpu->stop and
> cpu->stopped, and resets exception_index to -1.  Clearing the stop flags
> can undo a pause requested via the monitor or by migration, and resetting
> exception_index discards an exception the vCPU had already latched.
> 
> Only the kick is wanted here, so call qemu_cpu_kick() directly.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hex_interrupts.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

