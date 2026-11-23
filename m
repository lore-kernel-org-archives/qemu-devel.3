Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB79606A31E
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=evo2o5OW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=bTq3405e
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYO1-0004MT-OV; Mon, 23 Nov 2026 13:03:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYNw-0004LT-TG
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:03:25 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYNv-0005hO-53
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:03:24 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGH9oT3475364
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:03:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2t7P7yAMh27Sp0f3q4HeOnf72M6+xYdghzD6FHmU0sI=; b=evo2o5OW9gunq0Mn
 +9Ks7uKHNktxd3t9fMmOPYVAXuzNIoMiitr6P0shECoJ4B1A2jOU2wNk/mCtoA2B
 kpVKsEMsXKwk/sAK3NidIF1KKSHizGwb++hmZoMkL+Yu3BsO427Pa3akJda8ryV/
 zcoRrJTvVwNAeFDMSk49Y2pfKTXvSQOi8a5FANHsI+lzJvtfDI2B2duhygbpIVSm
 RB3myhnZtwhds6F8UNeOCc+i0r8gSkcveSCITrIntB9BtscD+VKQd8nslqu+9Trd
 t2wLXynm4iRHJD0a2Ay7UEtmdIQ+VrXjMOniRyRCLfQfJGa6kW1oDKXa/oSwYWAU
 qYi/oA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4hn7tbu7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:03:21 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-33713e5e6daso6496865eec.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795457001; x=1796061801; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2t7P7yAMh27Sp0f3q4HeOnf72M6+xYdghzD6FHmU0sI=;
 b=bTq3405epSECcj1U6zUm0iiMGD+RHUUm6y03O0dOA2Rwzv9Xiuk7LnA5ASjokBwgat
 lLvsk09oZKYPD+bl20DIZ7xoyxjb9OSOoh6bGom9/ZMTeYcuU4ZiGLLxMd/nOpD+1M4T
 TNr19KLs0nDz94OadLQAu4iKuPapLYjhgicM4iA1Bxnqv/N+Z5swyNxOolfmfWVXNPK9
 l62GUbOoamxI8KV6u98qTZGMiKFAJjZ7gySjrTjdJRcsWKYt+o/Gu2WPOZUiBA6L74gr
 UhqQD+vPfluswWkTqIf5hu8/3FXcsIw1S2r3SYZ5tY4i9I9usZ02IWNSw7+77C6sEFkz
 CpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457001; x=1796061801;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2t7P7yAMh27Sp0f3q4HeOnf72M6+xYdghzD6FHmU0sI=;
 b=AH3SCcQwtep+jcrCbE9nEn02saggWCbm2tSl+tvzL7D2BmDCcfZ8m+UTZ0xkJbQtnX
 bQWC6RS6YKtO2wONpwxEsLCO88mThwvo2z/i5KRpjPZQBEbwZ5Iv5emI5z0fRJ/+a9Wt
 s/o9zNbHzRn6UgQh5/hg1e+oWkfeRaYbCF3YbnbCe0Mv8MCOStzWj42J1upbYp3/5W3G
 4RUXKKRK2Q096LDM2hRCu2mQGujmxJ+ycKEXCm+cN2VgAq6KTMHH9Vd0fjFRw4AqVeHr
 Pk0vAaYtkJrnNV6Onc2MPDZ7aFGO0hTbc42dMjCFHjlsViP3wpbhs0WNl4dV672CLfk+
 X4Jg==
X-Forwarded-Encrypted: i=1;
 AL+hErEQABOYQkWGqyGpXDNGO1LIgnmvCB3u+05ul8ZzoB1v3IWBpXY9Yw1uDa9t9u4c6oZFafplYB1dg5jR@nongnu.org
X-Gm-Message-State: APuU4Z97d8c80bq6w5CD/roBJEWa3TaJhPFR9Kwkv8NHBAwuibhYxRM1
 3TKNM1gemxzMwObwvUx7QgymW/p2JyHlkVfemaoHmIyrPzzWQ27wvlWxasn6SjtXz3Y9VMnLOxi
 OcLimbOINjKxe7G0NT6ceJ/tQOpkob1d+iESz9FTGAmFupyPh6o0ExmBrvQ==
X-Gm-Gg: AZFdTZd7BKKdQAIfbYzqe2G/rijnf3nfT6AzODvQZdjuE5zRpSMNJDFFkJEe+b49ld5
 5OrJ0Kgjlv3UevXi3NDE8EYK5p9+ewlSx1OfEo6pz+kN9brCjCUX1P570vXumGE+3jvQXAJm7H1
 kYT+Q3zRchNNTlXIGHQsbwiDGxcWjJLE40GDhF2BucoX0xLT3rhtbUWGgTwy+q76fBXZtQkovpy
 /F1WSY6ZWBHdJhScFb7NqiFUq3pJJ3bdJHJsdMRTVzQC78XGiM1RW/aBW8hS0W1IoGNaSY9dR2i
 L7BSIGDrpsT3YtuY08Ppm4qBrvdxJsqNwFsEGiHEJLozre0D9JQKjOEf5pkAb6ma5QmwJEQRF1i
 g60CfU32MKkIvR7FpPsZKYJ4MpkYJ5S5VLNzEjCpPRw4LM6FiRAupCpXpsIk3IIWv0tuxYRZpyo
 GMzYsRJd688e/8EpTYW2rd8qZDILUD
X-Received: by 2002:a05:7301:26:b0:37f:d740:51d7 with SMTP id
 5a478bee46e88-38571b1308dmr13070890eec.41.1795457000678; 
 Mon, 23 Nov 2026 10:03:20 -0800 (PST)
X-Received: by 2002:a05:7301:26:b0:37f:d740:51d7 with SMTP id
 5a478bee46e88-38571b1308dmr13070856eec.41.1795457000063; 
 Mon, 23 Nov 2026 10:03:20 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567daaf70sm39518066eec.28.2026.11.23.10.03.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 10:03:19 -0800 (PST)
Message-ID: <31cd6424-c1d8-4122-9a71-41f283247e03@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:03:18 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 07/12] target/hexagon: raise decode failures
 at the faulting packet
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-8-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-8-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Ls0HWXdc c=1 sm=1 tr=0 ts=6b047fe9 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rb45iPhcI945g2Ro7nkA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX/xk/P3QpcLGQ
 4ocWMrO3Ml3ojAJ2SiKopDEJ5nIB6PM8nCQA3H0THty1738MEwj3uL51mP/JfIBWlm17BqsFseP
 hUCLDwacpDQkbhGlbx9u0ihvgtr0z8KZOnFhMvh2P4321BGo6HvqMBiQlWjRTeCTRo7or1YLe96
 64A2Br3G7kjOVp5my/3wyxoRUv4nINrcJH+tTIFuokYVXbvs3TGtm9F4lkgVvERItiDTTUskDuJ
 o4LvGCsM9j3JvjLvrDQnYnQ9ZJ05FlxDNk1JbgBLrZkS+uGrEhiL/nYjRDSGbpf1AKbpg46Xsej
 wqtEt2iBPubNwn2NE1SUhXtGcC5DxH9gTy7SrqMuFH0xe1ThSfNpCrTV9dYVb/MjCojFIu9qvEa
 3o2paumWSJeWbkU6vvkqMso4oTuviwDz1uSeVQ5IAFYUjfn2qSf5y2ZFoFuQMRSYYyYFud3d9Be
 Fs6Pvcy+1g9yDK2CAJg==
X-Proofpoint-GUID: J59E2iEProd1eKNfkGqZDhBNrzmDMm-f
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MSBTYWx0ZWRfX+cYYu+Bu9JJ3
 27HSY1oSatpmakQiP1v2GPCo+HNPJ8MxQbfkLaFaHg//LaGtjkONAINxSIxfaP9fQ/NvVZVm+wS
 JBMIg2VUh2BhDa98yBigRoacIoLAMr4=
X-Proofpoint-ORIG-GUID: J59E2iEProd1eKNfkGqZDhBNrzmDMm-f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230071
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

On 11/20/2026 10:20 AM, Brian Cain wrote:
> A guest handler for an invalid packet or opcode skips the packet by
> advancing ELR past it.  gen_exception_decode_fail() raised the exception
> at the address after the packet words, so the handler stepped over the
> packet that followed as well.  In system mode report the address of the
> faulting packet.  linux-user keeps reporting the address after the words,
> which is where the invalid encoding tests resume.
> 
> This enables the llsc_on_excp systest.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/translate.c                | 13 +++++++++++--
>  tests/functional/hexagon/test_systests.py |  5 +++++
>  2 files changed, 16 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

