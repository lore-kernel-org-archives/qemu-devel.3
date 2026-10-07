Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F95CA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:21:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEOm5-0000RY-Bk; Wed, 07 Oct 2026 06:21:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOll-0000Ak-DZ
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:21:05 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEOlk-0005y4-1e
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 06:21:05 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6977jWjc2481340
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 10:21:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EgHO68FMBkfr7TSpza7/01c1bex5whJfNiOkJiLep4U=; b=Tz3Ht9JRNOdEjOhU
 PRenTQKr13a1i9kUjWKqGe1Puvj0dcprnvLpQYHxkBH5uxwqI3yDhy64kjpI/Hyg
 P6GQcQm9ifKuNh32aKxVE3CnYT4NiywejUSabR8FeVcEDE+wCE3Ae54tJi6Ql/QZ
 5Du7BfIU0gJynnQiumy6EabU6v+RJ9OC6DizWD9TlogoxmBHELR1l77vArU3Knhj
 j7XhXt4FQFg2sGAcHADy93iGVFLouR2Wt67X6nCe2avv3C/GqqnQ52Rv64MR9q4o
 gf2reY6K1QFnJMtFoeO0+csLlJaxC/hVQ1/AJUSrsUnna1MngBu/I/XMKF9HbriJ
 +N7bJA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5c6u1n1s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 10:21:02 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-936aa34873bso759699485a.3
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 03:21:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791368461; x=1791973261; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EgHO68FMBkfr7TSpza7/01c1bex5whJfNiOkJiLep4U=;
 b=ZXCQdE8avoQC3e+9zwW+QhJJ01otcRInEUumyk3+WXueZh5cm0e57dcXxnMBHk+xeM
 uUul6b2aGLhLRa6oMNbedzx15Xl6ALREA2uhjFfE1Btcs86MaXm2p6geqiG8JaOhfpJ8
 zoiPIKafeko9KMkTJbTI3a5Vu/XgDfkPQWPy4UP2WCp4qs+qcbQ5s/Gcsx5jFUpiRxUL
 2DPAhVhwjGSJb/5vApGdta3YnIwhs2HjqmLmt52bI+gg9c4g3ZgNdTZH71SnUVrLjZ2N
 VQce3m0VMjZej2nafXhbIq3OFFqN8F7kyMObnWhUkbib2EneT80gfiNoLrjhsZcS5SF1
 MN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791368461; x=1791973261;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EgHO68FMBkfr7TSpza7/01c1bex5whJfNiOkJiLep4U=;
 b=LX6OLkpAbGEAdoCjTLlknBlXqHJOuIRZwDpqaLh/MRb8YfA0HTbdXXedf983Dgwf4w
 vCiYzCEbngtCUpVmjQYo1UjM0eBqjaHZf3FVRyo7A5O5M51SbP59yxMPvEpQONq5OWq2
 jh2bJUxkaTwIyitBZeJ1I20D5xhuUQTbGLaPHFmGDffKM+D1h4bwRz2rGmISB2f311ba
 d3XgjzAtGJlvXGXs824SUwqgiBOnAxeRFWVSGUe6E8AOLuQxYY3PhECB3IpaLplOUkeX
 VOuZaHuT82nwqaRACCXl7CspirEQkuVEclpFrGGKVoRKanEpLtb7ZpeEd0lAWe8TCOvA
 zcxA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwuaO69kSBy9etPkEhs2Ft30vJjOLy1rNWVkVqOxKA66tCOmXkRrgxQG5edgs/W5ddoEz1/+AoJmnPh@nongnu.org
X-Gm-Message-State: AFuF++k9MV/VIe8KVp4bImk7si7Yqh03w0dOG1f66Ccw++YPcRZKcqKq
 t9021T5SMhhb3DqRMlymCyfcFvc5UprCtkD0DfVHypKnrzTgAvsfQNWUeyVt3u0Ix6+q1Mk6rSO
 EN37SBgNZf8Q5Sbht2xc4RBDLesRzadL5jCiE3r9aXgBcLZbu5TkqKgposw==
X-Gm-Gg: AYBFou0XhU04j/VF2JkMfQXvDTi2ts9/+nryZS1lfQaCA49wqf1d/e6HuQ39FtrwU1G
 08Fxh5j0CQKNzKyL4o5b3I7gWZxhwrMtJkW/r6Wl7VPtoLbSFYuUsRhuaZ/vy3fHkkAXnTt0v3e
 ifudTvogtIQpdcWWDYqtyuEayzacyY43kvrxEs43VCpIU2wRRlwVPMLW69EmWoUmLkynuCrvD9C
 04YHbvfKhOALXapFyohDiWwytSQPVh6PlCaD1KXEuQr0YFMzzKve4KfbCyougzvv1gs9DuFKMb5
 E1fd73XUfn1C6JG3xBq4w2WAPhcOMvesdIZPOJFiJERZmtNb6kEoMyTtSUwhsyYNFewAk5gHRk6
 H7/qSkfu/FczbM9hRYr+QT8n+i46uuGhtzQ==
X-Received: by 2002:a05:620a:1d06:b0:93e:9809:8385 with SMTP id
 af79cd13be357-93e9b87fd17mr331857885a.69.1791368460995; 
 Wed, 07 Oct 2026 03:21:00 -0700 (PDT)
X-Received: by 2002:a05:620a:1d06:b0:93e:9809:8385 with SMTP id
 af79cd13be357-93e9b87fd17mr331854685a.69.1791368460349; 
 Wed, 07 Oct 2026 03:21:00 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48c71c0b7f4sm4703619f8f.17.2026.10.07.03.20.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 03:20:59 -0700 (PDT)
Message-ID: <0f320580-3c17-4e9c-aab2-3123323dc960@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 12:20:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/18] target/riscv: Compile cpu.c once for system-mode
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, daniel.barboza@oss.qualcomm.com,
 pierrick.bouvier@oss.qualcomm.com, palmer@dabbelt.com,
 alistair.francis@wdc.com, luoyonggang@gmail.com
References: <20261007-rv-dedup-v2-0-8a2f0f296a7f@rev.ng>
 <20261007-rv-dedup-v2-10-8a2f0f296a7f@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261007-rv-dedup-v2-10-8a2f0f296a7f@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfX/k45T7fDL6+k
 ostJPdYMCtmTP8Q1NZ0fr+n/+gRDPILjVOKYMectAHbEmSWhx7S6awQcdAfEoCt1/iLz38TDhEE
 1+7oPBEvOv5b94ZAPV5b6vdakIkhiMQ=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA0MSBTYWx0ZWRfXy9/w14+DVolO
 9JpCzzI7kMU4B18hd+hzSQVOCgoTTr/91UL5T6S8lC3nMmR39H5u6hRxE//BtiuUHgpUipTlCjj
 1XR0EPy7S19VIQT7TuIR7TtTlmcYefIcsWba8inGI4L1XlpAsCQW84yHyHgrzCng6qfoPoGlbXu
 jgmaddXw+wIEWos5HO316y4UB/cPeBhsIpjcp9YP/J+UVEiPGkRNwdwnl6bdm3dXxEvJX9hz82d
 yNUzJMGEz3lyd+IHBjNtA8O1sfiCFvqKY/zymJhC70ct4tD49ZGWoGI6bFSARXBb2aEB26YZq7o
 yCvIZmJUZD9xPPKGCsdDJ7M2an5tmoz5mgD9UGEAJaQtX9lXSCRwKqwp0qvOKS+SiTs4Ar9iJD3
 SylQ3pgdY3Llzh0WJF9C7qfvk4J2/8bSWzl7mHrw6DXM94Spk2RmT3jdZW7/vP5O4Ev1coNA1jI
 QY2V/EQY4GB3Wao10WQ==
X-Proofpoint-ORIG-GUID: cixRe-xJJ6f_TIroJdJ6EfLpJeXmhrVy
X-Authority-Analysis: v=2.4 cv=T5EZ3PKQ c=1 sm=1 tr=0 ts=6ac61d0e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=VxAk22fqlfwA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-GUID: cixRe-xJJ6f_TIroJdJ6EfLpJeXmhrVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 clxscore=1015 bulkscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070041
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 7/10/26 10:43, Anton Johansson wrote:
> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/meson.build | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

