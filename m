Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94FDB606A31C
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Nov 2026 21:44:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=jQkpfDQE;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X2P/3Zuo
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xT4Uc-0004Lt-6C; Mon, 16 Nov 2026 16:44:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4UZ-0004FM-UR
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:43:59 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xT4UY-0002lf-BN
 for qemu-devel@nongnu.org; Mon, 16 Nov 2026 16:43:59 -0500
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AGLCQZw2711468
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:43:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ynwoWx0AyxXH8ahMT0fdpby5rWXK1yuX0S6e6xxR+AI=; b=jQkpfDQEXfGvSrjW
 3IlSeA2WlHsVMZ+zrxnptWfE3DBuCmsFnGUDM736q7sJ1bWaHKgQwUp2yeY53pew
 e6T1YUiebf/1/gyKzSNBoLNfYQ8/XnZ/f+KL/DdFhqNQl87uel/IlzQl9uLxraHg
 3MhWSSYvUuhI1Ht10f3i5yiyhjgTr8Bry0IdxYHI9s5j35Frv34wVteuaNyX2PYq
 tJekSrqBvAuVQ10cM9TMTuWlQij6qkBkz+d8ot2rNtJ4ATxOlPPtIUdxUkNeNttS
 0MNjm9k+0PSANVWf5Da47neAywdxo6izjP4GIAizupt6dV5fd0EzdoM20qPTad9g
 M9OWPw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j09htg391-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 21:43:56 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-341eff9e381so6057725eec.1
 for <qemu-devel@nongnu.org>; Mon, 16 Nov 2026 13:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794865436; x=1795470236; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ynwoWx0AyxXH8ahMT0fdpby5rWXK1yuX0S6e6xxR+AI=;
 b=X2P/3Zuo+dqc/z8Vhhie1Cxs458ex/r+M7HAiHox7RQSRY4XB864vsUHkbd3WvGE+m
 2YkHd+dyc7nPlEsL0HRSJFcm+JIat89YAbhixunOAOewZjHcwGpZ4ntJH52aUfnxDkSt
 t9ns861EMkFfYybiFkLJx+vzrNcbtryGM9G0k7z2pppz0Fk4b2I+uvN14C62zEDM3JfU
 d8cRwqTZUdmycPQw9w01pBVOFLZpzQzSL08Y85B+skK7CQL5LDe1J9r+i3h/g5SN2a29
 IMZlD0Htij2h31CJQZ5eibn2cR0Qes1gp4CMCZptRnXsF0Y9KmU5bM6ttx8DKnxnDc0m
 C6qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794865436; x=1795470236;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ynwoWx0AyxXH8ahMT0fdpby5rWXK1yuX0S6e6xxR+AI=;
 b=t4uvvymDN5ZoZ5P4JgCeQkt5muNcCQJbPLN9fou0i907l+PhIDiMABd2BIBapnfI4F
 /qvR1hEx475BX3auYugqI/0apcDZPuZtp/mnUQAgtx0/rGibUvMcqJu35QJbNtAjto/u
 d+ZSock45BOH5VczD6LPSPY0g0kCvaSqfc1M2GSB6dBiuU1BtI1GQS67U6m+LYs5f7YV
 Py9kJ9GkJThJ0T830Y/R6hryRH6iQVUOYZv8HR0bwu9SoKeGP5LsTVe2gjKRi7paGPe+
 ktda5Xb3/vYG5OS+aituO/luG+ZNPyQn308F3XsZ1RsDyBI4moYRxW6ErcXVaGVrRalZ
 hBiw==
X-Forwarded-Encrypted: i=1;
 AL+hErFY1M6pEjuvkQc/Sv20FS6Iv69dW30L2TDoPdwZDL8r8mEy8C3RzRwDC9rQ7RH2YL3NJozrS6RD7ShU@nongnu.org
X-Gm-Message-State: APuU4Z/VO5sQWsUIhAoRmqY9qQ9/W4lOBIFqd/+/9MCJDXwaaeVJg8WL
 xBvt+tgvw8zvN4CuaGPOIM5bgnSl4sezBf63pQidwaM/ngyqscl/t/xKZ0sl9aWQBpEm1QWWCcF
 3kTkxwmysNsqWyjlr5bxY0Y0O6tVs9mA/wQIiV41GbgAN2/ByHaceNz2kbw==
X-Gm-Gg: AZFdTZduPWm8Tbo/pEAhDANK9Ow4xGp34J/RookqlNRNK4PLi1HHkyMYIa4FEv/V5f7
 uaCs6n6M+yvvOY92ze8238WoAeMsFkzoK8WhHHozJ//nRntpAU4ozHAXMjM5Ho1r5dbV3ziexey
 Tz9w7bmey2wO+kp/5Gms3APpywdLBMRrxGk+JykLVfsc7PVQ0/8XdT++JWUL7Pa1cv6SkzH93s/
 b/NHlHK9NhAnYBxLWf2mxjRPlDGXJMME7qdZT/us4eE/Dymr7dSNOx4ZbbNmHekDbscfOlGq6yS
 BwOXSomoNeKn6VwP6EUiR8vPGLXLsbjZ4qWw7ZVWMhy32sp1DZg1nCKpqEuZhiBeOAd71uI5C12
 5CgLn98rCMBo6fC2o/Op/i8QkmhuSLAgwqOmoXjtz6xMS2K0IjrM4mIoxfGx0Zvelr+OhMzadUb
 Y95cKjUhmtO+CfKiFpbGZd51wlFbfjr5Z4QjUmQ23WUCQ=
X-Received: by 2002:a05:7301:db8c:b0:36e:20ee:b297 with SMTP id
 5a478bee46e88-37965ca8716mr10032465eec.6.1794865435761; 
 Mon, 16 Nov 2026 13:43:55 -0800 (PST)
X-Received: by 2002:a05:7301:db8c:b0:36e:20ee:b297 with SMTP id
 5a478bee46e88-37965ca8716mr10032454eec.6.1794865435223; 
 Mon, 16 Nov 2026 13:43:55 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-37955332ae7sm56294764eec.8.2026.11.16.13.43.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Nov 2026 13:43:54 -0800 (PST)
Message-ID: <6ad686c4-2ae3-46d2-be71-80366d27abf6@oss.qualcomm.com>
Date: Mon, 16 Nov 2026 13:43:53 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 41/48] accel: make TYPE_ACCEL_CPU name target independent
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Markus Armbruster <armbru@redhat.com>, Yonggang Luo <luoyonggang@gmail.com>
References: <20261112133054.1977618-1-berrange@redhat.com>
 <20261112133054.1977618-42-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261112133054.1977618-42-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfX7y14xocHCALG
 fANZIxIsSUvOr9rCaQirjkoZsTlDO+c9OMvX18CWNn5r/i3VslqQAewRVl95n+Ti+mynm6na9PQ
 i7Hh0t2hSIxMphS2A01dnEGHLf18OkA=
X-Proofpoint-ORIG-GUID: v1t6PDx8B74HyVs4GvEX-oOIIA32rP1V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE2MDA4NiBTYWx0ZWRfXwH7EYr9aiTQZ
 xL1SoGtonklgexMurwlO7ylEyahsCgr7SnP0PC6UnGJ6OXE7kBByvwWajjb13eDT+4xxypzsgtf
 gX9S4YvYa1eiG/GujlhKP6gexR2Tlw0pV+rMhQ9nXTAInG2Vv6NXinxwNP8qq5j7hD0AcC1J4Y5
 CQf8mMD6KOFLJcYZpb01N/KVLwk6lAThEGG4GIwhZ0+V4BJfgIEj5XQEje4ybpaMXZIw6BpS9bn
 3ADbzOshspE/8ir1n3J1VRCt+ccNmUMGRquDDm36t0nueoVysKO9HTW+Pt5R2ZryuQoRt/GD9SW
 sWziWO2+xDnV9K6XbLysjSrJgUouzr7CMCqHqPucc+bZTJsUCB6+/MiHX9E156DP6RgdKSv//lO
 ln2cYeLb5lOs1qHqAWZMDthYJ61iuNFAn/xZArO6DCJlM1e+ehyONKEY6suEjhDUO+lrKZdz/Ke
 BBfyT7Pbo/N2y80oP5w==
X-Authority-Analysis: v=2.4 cv=K963jCWI c=1 sm=1 tr=0 ts=6afb791c cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=tLLZ9uLT7MGecBVHqckA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: v1t6PDx8B74HyVs4GvEX-oOIIA32rP1V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-16_06,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611160086
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

On 11/12/2026 5:30 AM, Daniel P. Berrangé wrote:
> The TYPE_ACCEL_CPU QOM type name currently expands to a dynamic
> string based on the target CPU resolving type name. So we have
> a hierarchy that looks like:
> 
>    object
>      +- accel-{x86_64,ppc64,riscv64,...}-cpu
>          +- kvm-accel-x86_64-cpu
>          +- tcg-accel-x86_64-cpu
>          +- mshv-accel-x86_64-cpu
> 	 +- tcg-accel-riscv-cpu
> 
> where the middle class changes its name at runtime, so if leaf
> CPU classes from different targets are linked together, their
> immediate parent will be missing unless the selected target
> matches.
> 
> The TYPE_ACCEL_CPU class is an abstract base class that does
> not inherantly have target specific logic. It is expected to
> be subclassed with children from different targets, and only
> those childrenneed to have names derived from the CPU resolving
> type name to ensure unique QOM naming.
> 
> IOW, TYPE_ACCEL_CPU can be given a fixed name while keeping
> the same hierarchy structure:
> 
>    object
>      +- accel-cpu
>          +- kvm-accel-x86_64-cpu
>          +- tcg-accel-x86_64-cpu
>          +- mshv-accel-x86_64-cpu
> 	 +- tcg-accel-riscv-cpu
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  accel/accel-common.c             | 3 +--
>  include/accel/accel-cpu-target.h | 3 +--
>  include/accel/accel-cpu.h        | 2 ++
>  3 files changed, 4 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

