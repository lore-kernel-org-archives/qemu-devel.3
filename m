Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82CB8CA5FCE
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Oct 2026 22:12:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCP19-0003Rk-3y; Thu, 01 Oct 2026 18:12:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP12-0003L2-Ok
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xCP10-0003Dw-Vy
 for qemu-devel@nongnu.org; Thu, 01 Oct 2026 18:12:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 691Fscal2267959
 for <qemu-devel@nongnu.org>; Thu, 1 Oct 2026 22:12:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 JN5UP3/Y0Edzbm8KIUD11LysXxLArl+eUm/T13c0Q6k=; b=n6cH/SVutZTXkkLC
 GxUBbsQitF7mQe29dd5wSSYgrX7xUsP6ZL+xvDxsR6RNcs5V5uhfREyjchpPMn9T
 /1DxUu+wTfEznMyeNPEceAJssnOxiJOEp7r9i6fiM426TJZwEtZdPUnCmIxPh5Wu
 BetRtOtcTnVr7E2iLSonI1zKY7BTgi52MyuJSho4bRE5acphsPAukdhcSB9nZakp
 5W9EQJoYAzY5bLNdrAq0aHPxgUpFVaOTD3wJucSvt1B94MoPILXNpXMyNlfJKQP4
 Hg2SEXGdTQfo2S1jHX7CRs2kRWbuGp4Q9yVxftRkEHhMgjhJ7TQD0SF7qEvnA7LP
 rDOzlQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h1rvqa4w9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 22:12:33 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso9860287eec.0
 for <qemu-devel@nongnu.org>; Thu, 01 Oct 2026 15:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790892752; x=1791497552; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=JN5UP3/Y0Edzbm8KIUD11LysXxLArl+eUm/T13c0Q6k=;
 b=FxDWSk7/fUl7tvYX5Em4rYPpwza47aycPuG2we6HGzyLztnd2D81SsP8Nj1LAQ+Q7a
 cUOn7N0ZAyV4erqVdquGyocpQWdwvz6SmI4Eo7B6vhLJmvGQf/ls0pnPdy0S68wOVzcU
 8YdgrWDSL4WW7LInOynfQis5e5cFafQ5PdImAsxAhACHSrlyUYFG40v03W1wjVAfpnjs
 3fod2akNZ7qAwValP/U41jkyyc1D6tUGmonUx6nwQy/Sf3VyvurVZUw5KxM4LCZYt8gF
 TC60fh5XQnok0ytzqpSvXQA9d3fSGvuqwoNrrgRccl2UA78KEa9/2maaNsImOqRk2txt
 R6hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790892752; x=1791497552;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=JN5UP3/Y0Edzbm8KIUD11LysXxLArl+eUm/T13c0Q6k=;
 b=lhCv5kCTZTc8SbT09eG8IcSUfHW88LZvKqH/X5CVEDryCnilEfzRWrtRQYs0KNenTc
 ZcVob3mtv00/HTPbEMH3PqQrsTifkqihWI2YRjvl4WQcsvoOEmU2mVVglpCUsKomIbRa
 trZ0GRbwTt0Yoij/eZTcmnIkQEoSE4YnZoSXnfKFhn+4wuHae0ujy+5cegOYFS8qy8d/
 jOkSDiSkelFzstrJDjtdqSS3HQcs9hor1x1/y8/mDuIcSe3KKMWQARjLYgfBVdwmxS9s
 XSKxXhhZN32MtfdbRfLS4WA2xyHIuCAzp/p/TMajnw0hJ2HAZOrnl+Q/iyS3u6Qm2Uk6
 UApQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxxlJtkdlO2r93TP3vAz067LIjfrpU3gfXU2o2QpaF6Nvl9WauRRRKZj+n6BjTKW0e4igR9wq5lPuC@nongnu.org
X-Gm-Message-State: AFq9FYIQ9OYxW5X0P4eMnirWTHRPjQ8ksu6ffcN2Dd+xvqrzihddVAEY
 ho+kjCv9E4swQFi1VWjfujWLxQyBYOln3kbRCpf+Qy5CvpDD3ck3tMw3hQ0KxlmwUZXCn9ajoVR
 Ve7xLV7Y3WUE43BkdZ4izc/TOzxa7wddHK5Zz14p3NClL8orveIiPsqvApw==
X-Gm-Gg: AYBFou0OFsfsZs3Dy/J8epPGgDhk7KGucN6b/MhrAkDIwBwKyiPenKxxX3wCW9KdilT
 sofFoChmHm9PfgdYCoM0ne5Vxq/du7TbGTAXDR+gB9809RqiVjZDNSsBZmkc9sq0gwTL4HwHcQl
 qq/P21HPFmEYmPWe7d/vsOVeYT151XYKSo0X5SXpriTtui5XZs+t1CtOp56qTYe57BYt7Px18AA
 MkWrpO9AnU/cab7Lz8TovM14xCb0ZXkIvzpOkhPfpZqgQPluT5MrwGOnYZHLU5g0DOaPf93eQyu
 sqq17OBCPwte79MhAGpW1nLudaO2stZEmXlFmf5f2KZUvhrk7tKHmfSDU0z8IoNQNErvCfNZEfX
 8SrxibLErBh5u+GbAfNAFAcYj01zzuDJgGGW2yTa4ich4XFjE4Wy5PI3mCcXgcS8xnTQgFA==
X-Received: by 2002:a05:693c:2807:b0:34c:7602:5472 with SMTP id
 5a478bee46e88-34f150d9455mr673588eec.16.1790892752336; 
 Thu, 01 Oct 2026 15:12:32 -0700 (PDT)
X-Received: by 2002:a05:693c:2807:b0:34c:7602:5472 with SMTP id
 5a478bee46e88-34f150d9455mr673573eec.16.1790892751829; 
 Thu, 01 Oct 2026 15:12:31 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-34f14f303e3sm1290619eec.5.2026.10.01.15.12.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 01 Oct 2026 15:12:31 -0700 (PDT)
Message-ID: <2b427580-fbcd-43c9-8670-0950878c6ed9@oss.qualcomm.com>
Date: Thu, 1 Oct 2026 15:12:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] target/riscv: Compile pmp.c once
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 philmd@oss.qualcomm.com, palmer@dabbelt.com, alistair.francis@wdc.com
References: <20261001-rv-dedup-v1-0-ea69b07afd31@rev.ng>
 <20261001-rv-dedup-v1-14-ea69b07afd31@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261001-rv-dedup-v1-14-ea69b07afd31@rev.ng>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX4qjVvu65XDJa
 lp9UWXF5gcG+ieJFde5VgFIr/j5HWszW/klCM02gVXiRbTCQyvO0gF8sZ2FjvMa8eLnDPqi57dC
 Et+9ox6BRMc1SOVzE6VTRAsMf3PxysGmCU4iihjU3Au2mmILFYE0G+9HSk+/UFEMTCbl9mb86eZ
 uUv78V+rT2Txrhc7U9zAUX6VISEO3XCt/Wqd/QgiIltBV4mh+PzvfbMmR/6B5iN3kLTl7EnLU4e
 ksQo3yM2AEiwDHlPVKtvlpuW89+ZY6efQarlLWsBtqn5Gj0eFUXcQQ1hmmvUbnIqLYpG9U7OY1t
 PaEpYz2E1Z6D7uukOMlL0kBwLkfv04B0eyP8AoTeFZhkyIs5mdzipGZ72Gt0cvKJgDV0kP5+63m
 zdvLxU1kQLViVf+NuwnQrE8hgWesGBp1CAtTzpNgu4MV2JNSdLKg9Am3AZNMCjJms3/eNcMjuW+
 jEVWv93O0LAPgJTYTQQ==
X-Authority-Analysis: v=2.4 cv=JIauIMKb c=1 sm=1 tr=0 ts=6abedad1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=fkZp-GEFjr1xpXxCPPcA:9 a=QEXdDO2ut3YA:10 a=VxAk22fqlfwA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-GUID: y36ineshutxh6utkjhn19L9M7sjddFPw
X-Proofpoint-ORIG-GUID: y36ineshutxh6utkjhn19L9M7sjddFPw
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA4OCBTYWx0ZWRfX0/RPTDHarZmf
 zAWT4obe8Q12hGDMII6lGAIcWramkfir5pcQvh6/MJ47g2gHmySElYq0Dwtbi/9ZnEkkxCGRy7G
 HkWgtQQR8Q6mfKF9IKyddVSXuNIQiNQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 phishscore=0 impostorscore=0 bulkscore=0
 spamscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010088
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

On 10/1/2026 8:59 AM, Anton Johansson wrote:
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>  target/riscv/tcg/pmp.c       | 5 +++--
>  target/riscv/tcg/meson.build | 2 +-
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

