Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64ED7606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 20:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=M83t5tre;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=VTf7sLbU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMtNt-0000Vl-Sa; Fri, 30 Oct 2026 16:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtNr-0000VK-9c
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:39:31 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMtNp-0004sx-R1
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 16:39:31 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UIcd734118708
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:39:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bqe7/6Nag0H/ItVGm2KaX4d332mVbP7SaOsAuKFVzZQ=; b=M83t5treeH2go7xW
 iSMKy3MiM0a51d0r4WwTHhwP2RuKXSmBitxTPmV7RMdnPNInzpx6mT0oejmtypmw
 KJ/SLeYdalfmHrXCp6sxxk8e9rM+M9NGySna7LOTiMeXLKQFwSQVsj3WiIQGb0Wu
 c8PuKlSJMXFmroRTkcoqUcgsUxG9+39jRt8HI1C9rykIz2Rmfg3Cw3Hg/In34Lcf
 RXbHeC6Kgc3sMPjnCl3N4huDVKB0SENfRpr/LKw/aMMzl3j5DDw0YV08t+Uv8SF9
 wVP3zpWsmQN4wFaq8AMikpzp9bhhzm28klfGw/BlTC9Xs1UcajygMkHF+On1FfGp
 lk0B9g==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn0pu8bdv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 20:39:28 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-35c5aef2a74so4422626eec.0
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 13:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793392767; x=1793997567; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bqe7/6Nag0H/ItVGm2KaX4d332mVbP7SaOsAuKFVzZQ=;
 b=VTf7sLbUqEfzZxo1o4/faJdd7+r1SDUmKHgCV9Z5j0m/5Y/jh/yxn/qRimC/+yb4AX
 NcLhGZIoHwA/Z3C4Tp2N8JKH1AIP7qPjW3D8P+S+1iDd83JpRl8ZJ7WzmEy/ig3VGJfj
 lPsMpOPfryAUlxDcIGupNT1yWVoboZSJfMprYixFaullMKPUKlqWCfi/8dMVtIBWaKZn
 S6HOtoZ+uFK5eNJdEsp45c0skcmYB8JrsegPafXtgruzxxIumJ3KogfUrglSaETfD8R+
 ke3Uqfumh2GMv9Tksgh22uNRKkcSozjPZqbBfEOfQPu4UEItrn8sqBXG38fo6s1JUmDs
 Wm3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793392767; x=1793997567;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=bqe7/6Nag0H/ItVGm2KaX4d332mVbP7SaOsAuKFVzZQ=;
 b=KBZSegIbkdtbsr6PLAgKPiCG0YNs6vl7lipOpih3Ck0U0n0HEFqvw0O2B3pM53yjzP
 qFBbOAfif70iuWWI/vkIP4do8hnM4ty/chNH6b7StWBctE7rLoSlhPr8jq8EhG3pHpMV
 DoHrrZptRDBOnsSnExCrj/YFVQP3QKdh3zN6LHpUKArYsozTWLPXD0OVwHJZXaDUVjKg
 +yHuHVP8QWdOSoG8PcQumeV/k5lnxB19T4vj8uNGcAWuCp1/kPwQSbLHQyRDRHfkRWgl
 Tjb8KPYF8+0HEZaE/LFTW3Ao1xzC64cl3hrHUNQnTu1vQOiueJzX0ITYPwO/blFkgOe0
 rM9Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBw42Jd64p/8hh3qp73G7ewWVqNFUgBZ1mV0Ebf4U1JuUjRn6Fkmxf/QSb3LcSnUwpLb5X4/0cUS1Db+@nongnu.org
X-Gm-Message-State: AFq9FYLyIXVknX3qxVpRtlejDDYsClrorpUg4fsNbhHL5JrG6nYMow2y
 /H3g7GueHIPa7Z16T/LbQtH0M41rbqXjLn0PYpA6DJM8JT6BCfblmC3c6dSHmGSltdXYrjJgy2w
 Ztk0z3m4KgDM5o9wyJwDxGg76oCaze1baeb3pqZLoWOwt5P5tEqKn7JXg5w==
X-Gm-Gg: AYBFou1qn7v/FUDQ4COsTXehIRYshQRiJf9hG7/My5OEryKxW+cythlTeGyKBdjuCCY
 RjkI6zDA+Ug0+iul6+S9TrjGlZFErvrrtTwO4cK0RMyasnljtKyryPtBXBgn6qukZ6I9aJUdfUX
 4Rz/CfVMMZLUVjUjjr6YU0/1TihzL/WKmcvb1Pcv3IPZ7PUacocMhehTPuPHNtaG1py84vObNy+
 6zr68CQ0N97ZwlDyRhDPFaE9ut8rtZvtxSmo++0e+wVzdpnK24fW0f3oBLzHqWjufgIPTxgLLOO
 E9tTTuVkfkbuHkUksCnOs+nzrcdIzDDW5puKvDllc50MPotaVEVvTv2BKyXNWcyk/8ofEGOaoNI
 f7t9sZ7zZkfFytr5oIROsUjItbuU78Yx4x3ATXDocDbxdpyH/XPAX+UsEuq8RLGuZfRu/1okf85
 JQiGv7Ib5U5FLA2fSzZi6x4F0E+m545BSmQF2ukVmyxtg=
X-Received: by 2002:a05:7300:fe86:b0:35c:85fa:5a68 with SMTP id
 5a478bee46e88-36a42400c6amr4902177eec.31.1793392767289; 
 Fri, 30 Oct 2026 13:39:27 -0700 (PDT)
X-Received: by 2002:a05:7300:fe86:b0:35c:85fa:5a68 with SMTP id
 5a478bee46e88-36a42400c6amr4902139eec.31.1793392766448; 
 Fri, 30 Oct 2026 13:39:26 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428af1dfsm9769682eec.7.2026.10.30.13.39.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 13:39:26 -0700 (PDT)
Message-ID: <bd744350-9165-4ce7-a4b8-220d2df8b71d@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 12:39:25 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] target/hexagon: deliver events direct-to-guest
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
References: <20261029190208.1169519-1-brian.cain@oss.qualcomm.com>
 <20261029190208.1169519-4-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029190208.1169519-4-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: sURw7tda4f4DUaq1KBrVKObCuVZKyFcT
X-Proofpoint-GUID: sURw7tda4f4DUaq1KBrVKObCuVZKyFcT
X-Authority-Analysis: v=2.4 cv=O92sLx9W c=1 sm=1 tr=0 ts=6ae50080 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=UNhg88EB0hb4iyotTvAA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX8uQ/rEbcqvN2
 puIrDFyBt3Oh+MklZw6Ozuor5hW5uCnx9W1nLdMQQlN5Hk7tbXcnIMIXCw5QdCKX2V8rSwqwS6q
 HuDgggstB3CoIC/h8TsMJYouqUK0aILqE/PDMBYq5IXQE8+DTH5w2Y3b+sd+XocHzTpkwYGFE6e
 OLeIr5CRCil9La8F2aljFiWqXbzoodLLGPMtzqJCyBioBwSkajZGlDRf1XOmu4P8YeKEO3OOthC
 K91Enr0DeOhlCxMlCDWN/sxeaGIiZA2CoFyjylpFYnzCES7IMM8UmdIPeRStPxGrc8OBpEBOR8e
 HlSkIazNFYx7feg9VSpMkLIcHlnKemNV/EEtF/Ed7MB8SAorHAZLS7w2eUoxZ2y7DPK69fs9tFX
 Lb16xf9fcbt+R5wH8lgxRcdb+lIMPWxu+1/eHHYEIzxIScXm7fiiED0IXTm7TEPXB6b2gR15v/R
 O49nNnBG0FSkdDNpZCA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA4MiBTYWx0ZWRfX35TT5bTCSq9G
 Pl3Yq/LLgnxDLr5jgFqC31gm+Il95HQVL1i5Nhl3dgirqudf/a8mQeESyA4oINSJTxr/jgN8ttV
 8rbVvn2PNCIKbtrYAbzn+UmqAaj11pQ=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300082
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

On 10/29/2026 11:02 AM, Brian Cain wrote:
> Implement guest event entry: trap0 when CCR.GTE is set, and precise errors,
> fp traps and debug events when CCR.GEE is set.
> 
> Now that it's implemented, remove ASSERT_DIRECT_TO_GUEST_UNSET.
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  target/hexagon/hexswi.h         |  5 ++
>  target/hexagon/sys_macros.h     | 24 ----------
>  target/hexagon/cpu_helper.c     |  1 -
>  target/hexagon/hex_interrupts.c |  7 +--
>  target/hexagon/hexswi.c         | 85 ++++++++++++++++++++++++++++++++-
>  target/hexagon/op_helper.c      |  2 -
>  6 files changed, 92 insertions(+), 32 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

