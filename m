Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE89AC61DD6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:24:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1V2G-0007xk-2i; Tue, 01 Sep 2026 16:24:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1V2E-0007x5-BZ
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:24:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1V2C-000425-M3
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 16:24:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 681HfxpJ3302438
 for <qemu-devel@nongnu.org>; Tue, 1 Sep 2026 20:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 vNy5M/JtaNZW+Lob491Q1vIMeGjRymAVlSnIK1H9Ofo=; b=MogmnGpHrGGO7f8o
 Q4vC172p/5wXHsYGWk7MhCvjZPnrXXQ2+HAp2jokWk+YEyt5GxDY5NR9f5L5kOxB
 zOClTlB2TFflwiF2XUmcv8vije7LYSCelVyr8/HaTw2Jy6LiE0jncnDv3t40/+fs
 MAYjlclrRkV7k7EPnnTru5L2cSnEjgoWJFsHzar2fjph/o8qFibC6weyA/SSTBr+
 Oa/bqyc3KThHMUDdoArOr1AlOC3V9EFxsjlTdyfLNhRRbUA/shX9GlYKcv/3tFhh
 L5Jdp//+r8l0b5Ff80H4Ewyz44ADNC6QhrSHhB4JpXAjc3mkwL0hfBiXBH2Kccdn
 A2tv/g==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge37j0qk0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 20:24:42 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-399311947f6so462040a91.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 13:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788294282; x=1788899082; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=vNy5M/JtaNZW+Lob491Q1vIMeGjRymAVlSnIK1H9Ofo=;
 b=RfuZnmkQEMI2jh6EA7sOecbgIatkBy18I+TobOWHBEoS8gQVxfXYjTnMnF3Us/O0nR
 d6ZNXBjHjynO+1LzIuOgVz7lzW1NALLAa4++SuZdfvQG1INKUoK7sUUElyHHNmh3/eLh
 e8yClp11j+4v4o98QHvL+Xu20HTr5gOpzbbW3aQL8uxx0FsR9/6hq/38WQM7UI14QCSy
 7vhkdZFRzek/u/RhytMNOSLEdJFeTsGwkcpUOzyRBH3B1Dkj3OeCNOOEDQ3zlvBDT0xt
 pU2fnnftdgjg+gnYRp3TY8aBO/+LW5OCrHJ2Varkom6Tj2IUW2VKRumdH56r7xs5shNe
 S5uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788294282; x=1788899082;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=vNy5M/JtaNZW+Lob491Q1vIMeGjRymAVlSnIK1H9Ofo=;
 b=JpXF1o23wUvg+Q0mfRkGDtvlJATR1zFegOcD8rkjPAoIxN2TpqO6hyqdV4s1Hw+MX5
 bdM6QmaMQ0kXqMhufC5RBxfqn04wJnO5zt+RZnqNJVFbzlD6zwiBHeMBORI2qpoaybjS
 RnOof5zWUgu4F5LXDLHja75BcYSvvME/vyES5mKqdbPkJhe9XcHHQdWIB+pqozw5KpP7
 5U8+wzR8IaK4yqS1w832x6wtTqkkzIZwYf83ByjtJhFJyw9x8LX9XJtAwC+l+fhziZKT
 UCuLBkQhUqGRy8LTOY+42wnjjLI5M0J4SXFXy9UKxlEo+O7SZyTzF0PgtMFUwLEuLGzm
 Mw1A==
X-Forwarded-Encrypted: i=1;
 AKwUvBwNEPPPEg9tup+wCrsztouIRlaZb/NAXE52dcYEbSNKdMyqxrcW9JMcCXfVIs+p7Lpmwrf25K2MogEr@nongnu.org
X-Gm-Message-State: AFuF++kLBazBsRk/W/QGadAnGMI3UepPFCE1UCn+jtHftPvDET3YxGuW
 gntY+EJY1jzl86hvq7lftd2KcO4nwOVVmBQ2wzp0Ccx8kH8I/OCntf6KyzlRtHJZOeDQK0TYJzR
 Ok0s2aCzU/xAyxPB486HCGFtvQgKeFuzUqG7DVGnTnMOjzp45aUeRw2EmYA==
X-Gm-Gg: AYBFou1MqucOWUe6NDdRIzjsSqYghv5w/8UT8SqQR4TCh2jsVPCzET9PDJPyvnmhFca
 jaZGWjl8W05BghVDRdrgWVgLqW93QQR+GNfPoMzoUDrepkVOZziHST4kLxThkyHHgbKNRhrPSW0
 UEXycNk2UjMbCTgpwR6I4ecatVtOLb6HfeyXEeuUs2yZRopq0/dmYmKnHInrkIcmpv0gZSxsyz/
 T84m58ed0vAyzSepuOc6bPVkQ1KAXqGVyo/T+VtZQkZcsaLp920krQVWDiC6cFXFEAFBXDgglbh
 +r+BVjbm6HhnnImVLhfW/T7lWN/maXBuu4PhJ/8aj2/2Ue6Z5xoxBQu1syaABmZ2U0hySM94gEU
 BtqqzprcqHT68GkwxIvNtDBCQWTe7KU0i0gSJsWY7LRak6vsToA+Js56TKFH9EGWnWdfY
X-Received: by 2002:a17:90b:4c88:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39ae84473dbmr923068a91.17.1788294281789; 
 Tue, 01 Sep 2026 13:24:41 -0700 (PDT)
X-Received: by 2002:a17:90b:4c88:b0:398:dcfe:967a with SMTP id
 98e67ed59e1d1-39ae84473dbmr922996a91.17.1788294281292; 
 Tue, 01 Sep 2026 13:24:41 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f07b7bd00sm434209eec.14.2026.09.01.13.24.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Sep 2026 13:24:40 -0700 (PDT)
Message-ID: <e13a3924-31ed-4733-b16e-1992324e2d66@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 13:24:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/hexagon: add OPEN/READ/CLOSE DIR semihosting
 operations
To: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: brian.cain@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 philmd@oss.qualcomm.com
References: <c186b1bbca79df01c96ffb1f21e1dadf83e01698.1788290677.git.matheus.bernardino@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c186b1bbca79df01c96ffb1f21e1dadf83e01698.1788290677.git.matheus.bernardino@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: AYCk1WZpGmCFnIrVRrQ6-rYu4jdQ8TyR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDE3OSBTYWx0ZWRfX2m5yiOATu+Qh
 dArdxCDmtCA0wF6LnbD3dLAM7eR9n/VDGiA/4OlRNEiGEXjtszZ3zrfUParZVNOSNwIlTuqa4X8
 17e3LZ/kAsOYxyGHGINbgvX605UolN4=
X-Proofpoint-ORIG-GUID: AYCk1WZpGmCFnIrVRrQ6-rYu4jdQ8TyR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDE3OSBTYWx0ZWRfX5p6fCklxLTih
 dJyINQdEzEt995GGV2x7TPmEC6xTJuR4CVh26GZbWtzl4kkzO73X4dC075+J4jwGivfQlNkYVnS
 GPK5pbUxQZuWtSmZzxHxGNko/vSi96dw4lehsOnjVjNW0kkfXCiQUKHxtOHyHDBLLYCNoMA21NT
 k/AughVSJBHBeRU5/hCus+QVFc8bHDgNH6Mwp3eSC/ghYd7e8yXHP91Uv6QMYe+3oOlZPPr82aA
 w3PsCsIfTm6yvfD7INt1UWHJFfDjYuMVP5JJ1flDBUFDJKMSn+ilruv4T7fL26iZCeIu5upevNV
 lsMh5gxJhFlJ0JByL7ZMOoxOAEntmhsRoO7Bb6ZSbukI/fl3CpdQfPvBAlWbx8gVUcOJSIab7Gv
 7oUCLxN4hcwoXY3IK1gCwNQj3eee7VSXbnlz+4Hlqs73cd9BiezSqQxFQh+teh5YoyXVbiRlYS+
 oLZ58SpgDliab8LAWrA==
X-Authority-Analysis: v=2.4 cv=PKg/P/qC c=1 sm=1 tr=0 ts=6a97348a cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=vN8pYNp4StamS1H8tDsA:9 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_05,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010179
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

On 9/1/2026 12:27 PM, Matheus Tavares Bernardino wrote:
> Baremetal Hexagon programs use semihosting to enumerate host
> directories via OPENDIR, READDIR, and CLOSEDIR calls. The list of
> open directory handles are global to all CPUs, so that guest
> index values map back to host DIR pointers across calls.
> 
> Also add functional tests for the new semihosting ops.
> 
> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualcomm.com>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
> 
> Note: based on https://lore.kernel.org/qemu-devel/cover.1787586642.git.matheus.bernardino@oss.qualcomm.com/
> The added test was verified on Ubuntu x86-64, Debian PowerPC
> (big-endian) and Windows.
> 
>  hw/hexagon/hexagon_dsp.c                  |  7 ++
>  hw/hexagon/virt.c                         |  7 ++
>  target/hexagon/cpu.h                      |  1 +
>  target/hexagon/hexswi.c                   | 83 +++++++++++++++++++++++
>  tests/functional/hexagon/test_systests.py |  9 +++
>  5 files changed, 107 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

