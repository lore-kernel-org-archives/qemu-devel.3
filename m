Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE336606A31E
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Nov 2026 19:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ZFmdqwxd;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fANItIC/
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVvrZ-00025Z-73; Tue, 24 Nov 2026 14:07:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvrX-0001yV-UL
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:31 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVvrW-0003sa-4W
 for qemu-devel@nongnu.org; Tue, 24 Nov 2026 14:07:31 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AOIXcpq2037153
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TqXYf7mj2lxRiI+Dd2OHCF7V23d8BqMgBl3jbXt5oqA=; b=ZFmdqwxds8GHshZm
 skHMtDR7XEjz7RtsaoPhOCvkml4nUAyVs0eLMWCIPoJ+5/mal5qc8qxDfaI6d23e
 O8BUugaI3kMADfDva/n2e4P/k85jjaXBTLR+xRokvXP0yoNX+KiV9sx+/ENeKXNt
 nVoRWQeDEfYVbrF6JxUrUTfvd8+yC+lJiM8roj1sXcN9MKfLfkwO2oeNuq9TmNiq
 3Rt0lLgDZmX9BOuYx5xSYitQpm6YnlSn/yUxoI4W5yA9HMhznBElGu9UhYAhMBow
 L/uuimJECBHam2lxp2id7CZc4hrKjl6rwG1pQXLKrdSPnnPliqbhSUzASXWbmTFI
 HMg9Hg==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j5dnggw79-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 19:07:28 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-38355b03cb8so4825686eec.0
 for <qemu-devel@nongnu.org>; Tue, 24 Nov 2026 11:07:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795547248; x=1796152048; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TqXYf7mj2lxRiI+Dd2OHCF7V23d8BqMgBl3jbXt5oqA=;
 b=fANItIC/SlVdGh2uqrbCKWX+0psObVeP+tc8y7K6kWkqPOxsrGYxBku2WqvkDYGWns
 VBEL4oFgsCi9hCYFf29aLibVePOiRt2MoxI5Llp8owArrRuN7c2ycNPJ/GyFKPN/OHgT
 Ga+++uHNtR/WkMr4CyzNbYPh7S4UWHG6DYc2CfaY6Hg5Z+WMEmYoy8zQBEKQ+ZRoAKv6
 73eSCBiaLXX+MBZt2Fngf4kOV83MiT3v4397GNwC8duCF2x3VEpnTrFEErgalx42AUF8
 DjBTNXjN2Ep6Jw9TYVcEhqg5LfkGGSyRQOjJGI0JRu6Ul55lvvU7B4f4exH0SxUK7ytO
 LzeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547248; x=1796152048;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TqXYf7mj2lxRiI+Dd2OHCF7V23d8BqMgBl3jbXt5oqA=;
 b=dqKG6NteEXXTNwCZyTOAhxBqP7uDk9eBXXThSGMv9tb6SCth/eB0ov9E+762PPj0hg
 mJctaNtEmZDO1A7EApfWjNjw9KS+HRtbf2+zn60U1lZNbpMPu4lqIQDcAuvtSYVApsug
 zOB54UdWC4Ul1Zm2pkF1KnPvTjHwrWspNCNwwRhxVfRkYS1ius2jXPW0d6+c5IDzfh0k
 fcO9kEExRb33AplCOjDNUf85DVKbHIJCQ0f1wC1UVWJiBE52Ml7+vY2kgb12IfMUOawx
 IUykh/NnMFMfgPS9Py0Ov4jFqT5e3uouMHwD6FW0haVhOPdXx8q0CtOLAFRdVZgDRLwj
 eSOQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFm2C2blw+qaFylkaVBMhxmub0eDkGHdpe686CqTSJKJBrIo6HtfCZvPQIe49YboxV52OSJctUr+A2T@nongnu.org
X-Gm-Message-State: APuU4Z+qMTx1z8fnmsORvqqSFgFvoKUJhtNBGnoBNvfW8fgR8WiNwiNH
 uhjZS1pe1BsCv7/NpQ7LNTXp0OhxZxmwUOOCyuDbqArOhhuD63xggOBC8JOa6pGarhctyJdanTv
 yYgS5whDred6fUh3UpY2tHGwgSXvAq5rhmxPnvn8JcGzfDoZ4T7V1eNjyDA==
X-Gm-Gg: AZFdTZcFrijcYosz6ME9cjRca0719wi8HO31O3OkAdh0WWZSfAQqcglWjzWs3vy5JbY
 HPJegbJtQ5ngZxjO8GieaV2XApYeLJSd0HR6RRefivJWEs1LPaHDG2BcTGxwBstpbJhX+hfmqaa
 G/5ys4BnLJOpZaF738P4ZvZ9sOBP0B6c8AVB4b5HhTS7QeX2KVnkDXlilsdojYA32snJdPYTwBb
 mdVVI5qUwA4b5TWBwSIAZmZlm8rh0Kuyux1MTrHEf602VWUlb1OokNg4bwlycS1BvwTOP2kELKY
 cBIdXRyJOtTrN4coKghSqx1KLuCuhRvFRyY4pZk6IYBk+MxsdNyYayqjgPowzAVZ7cGHf2DWuFA
 I2Ly5HRB4/8wtW40tJmyAKLRG4/Xxz0efLD9bX5yadTjV0e98Icp+EmxCQFRJeWcGnZx93nnCgg
 RNbl3ycR8jwIsy6+EIL8mt/rWUQteh1Yh3RMSOizEmawU=
X-Received: by 2002:a05:693c:87d6:20b0:386:b05f:2192 with SMTP id
 5a478bee46e88-386b05f23e6mr7353376eec.21.1795547247872; 
 Tue, 24 Nov 2026 11:07:27 -0800 (PST)
X-Received: by 2002:a05:693c:87d6:20b0:386:b05f:2192 with SMTP id
 5a478bee46e88-386b05f23e6mr7353344eec.21.1795547247072; 
 Tue, 24 Nov 2026 11:07:27 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-386992b404bsm35037088eec.1.2026.11.24.11.07.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Nov 2026 11:07:26 -0800 (PST)
Message-ID: <76763b46-f909-4e7b-a0ac-01aa4aaa237d@oss.qualcomm.com>
Date: Tue, 24 Nov 2026 11:07:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v3 7/7] hw/hexagon: honor configured RAM backends
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>
References: <20261124190314.3882017-1-brian.cain@oss.qualcomm.com>
 <20261124190314.3882017-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261124190314.3882017-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfX/gYR49RNGuom
 /kI733A+ZN6goizbDuvJ84zc2vN2wqUQ1/EEJaGnDx0U352H+hLXvBlvzN8uL/aGQsGFWAeLO+K
 Wq2p7v44/Sx3EmNyMpM4pX1yiAQ42NM=
X-Proofpoint-ORIG-GUID: atFvRA0sdQsIaI30yeeXbYGPLAe57Xrb
X-Proofpoint-GUID: atFvRA0sdQsIaI30yeeXbYGPLAe57Xrb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI0MDA3NSBTYWx0ZWRfXwjvYRAUaNMcZ
 OFQwvQGyRnp5GUXuefTKvElW+6WO8ksWyzYoN7uAB57do1MgZXv491Eb96croIA13q3KoG+5HfB
 RfaG7UkfPHFqtN67TPPTXxEWzaG0hJ1I99GyeJlSaNhhbUXkGg/zCY/lte8h9dCMBxncKDra7ug
 pFtzEklbdXJ8cipd8Wsu3U+ye2ZvgQbjMfrSNHWNYaDvQdaTicQ+2VaQQRE7DYbRjv7jPtPHhck
 o1JpOttU69kN8Im6tLE+3MEitiZjSAZ8P1NFupx1PM7dbbMNDO9ghObght9jpkyFuZS9of8UvOJ
 BA7EcFvbuHJOLJW33n5/i6m6uTYfV78ARyk5u3D1TGmdCe7AXr1vaUYOXQ43sutTHEDIoR5SXse
 QAbZW3VJqaoVLbmalJRSEHXi57H6Hfk0pnIFybeS08pooqV1dl0i2qfPJ+vT66/hVeQe6DIe3Ys
 R+UASv2fwKmsFX4O/Hg==
X-Authority-Analysis: v=2.4 cv=U9cHnuru c=1 sm=1 tr=0 ts=6b05e070 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=bjMIgEwd9pQJBBK6TcUA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-24_05,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 spamscore=0 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611240075
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/24/2026 11:03 AM, Brian Cain wrote:
> The Hexagon machines consumed the MachineState memory-backend
> configuration but always created and mapped a separate DDR region, so
> a memory backend given with -machine memory-backend= was never used as
> guest memory.  Map the machine's configured RAM when present, so that
> file-backed and shared memory (as used by the migration tests) is
> actually guest memory.  Keep the board-allocated RAM as the fallback.
> 
> Add a regression test that writes guest DDR and verifies the bytes
> through the backing file.  It fails without this change.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  hw/hexagon/hex-subsys.c           | 10 +++++++---
>  tests/qtest/hexagon-config-test.c | 26 ++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

