Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22533606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 18:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=DJ5k35qQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=IuBltSzs
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVYRb-0006ga-4k; Mon, 23 Nov 2026 13:07:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYRS-0006gC-A2
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:07:02 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVYRQ-0005VD-Ib
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 13:07:02 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGHHZB2845288
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:06:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tueOjZosWgIjGoafUEjXnPzwxzBATXJxlKIGKvxO48g=; b=DJ5k35qQ3f1BPmtf
 727wPKbaNNdi/pnLr8pD9tn3S2I8HOsDhxZs0MGlgtZ47ULFW82zYpSAPZ2Pcul7
 5GrvbgoaL27gAFApZow/ahPHd9v8Nh9ZfYJFPgNAE7T5YIyLiuzqmhFzDUkcKd80
 eSWzr4SZ8ATA9ps3jCtGW5sSlHzl7sh7BXYg86B1nYW1gmKp8lVVRNANDcEnN40Q
 +i4FXGX2VTYAAlzCxhwZDALndkmaiUWA10/6+dzViM5IDbQRJYE2lJLc2lwkhepI
 kJDCGygEpA3hGh6EGgO0XVwKCNLYnGcPvIC62ayKDN+6CDY+ogrXDMC3f5We8MeR
 Cx+I0A==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1k2ra3-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 18:06:57 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-38531c1a566so1842746eec.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 10:06:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795457216; x=1796062016; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tueOjZosWgIjGoafUEjXnPzwxzBATXJxlKIGKvxO48g=;
 b=IuBltSzsWGnqnghoDQ92qKXUGKRvsArEKHvqNMwoJqetrijI0EuZd3EcbcP3jxRzMb
 HcnkAz/fWG9GtYAFjnqYnCmqqZVPPC0uYZHav//G58Yx4XP0HSPozu2vH/xjZxNnk0Bg
 pLgdc7HZDY97RqOth4FquJIGhXUGk1hj5fXJoQCjh/devq8avK6zq9Vom7ZZklDSIE9U
 j45xDwpxNl9Jn4a8XTxHOJpRB41u2BHHwVhFILPtdNzm487ryVenqDgD8/vKTPQthwp1
 9E0hWqGitHanJkjymOaMpb4f2GSwkzWfHaSZb8tTBcGJBKxdFpdpNHxsaZ5jyQOKs/XE
 fJng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795457216; x=1796062016;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tueOjZosWgIjGoafUEjXnPzwxzBATXJxlKIGKvxO48g=;
 b=usNzBkn953FOUUooDUH4bHDKKbVTad7c4zJstMPcF/ZgmHqkMKPhe6O/GCdfuJUR5h
 4hy1UUyxOthlnELsWs1VJIYZPW2Fy5vS89yNyT0793Zi7iexclf8IfzAZOPqUSPNA7nx
 4vhpjO+W+b8wEHzgjwVoesxsMrMRHSqqPTazhZPk+fQKejdZPtVxIgV7w1px/QGryaDQ
 ehXjThT9WDjZK2X0BeBnqFPST6m5xRWu0IJ7utKzrbMBVMLbYw/mnsUvFMb/ytmtNK67
 H70pHsKLnkNuKDv1JHwD2FuiiWxxOrRq+dKUtx46lOlNsQE8bYdTivEJgf+pSeIO1g1I
 3tEw==
X-Forwarded-Encrypted: i=1;
 AL+hErFEeCUNqHwzbFI7nO+IXgZ8Gfy4HHQijjgFz1OJ1Qxhq4/0Cr37sG26lALuEXFnnt4225DOEncPEa4X@nongnu.org
X-Gm-Message-State: APuU4Z+Fx+0aj7YOcLUplC4LvY5w+/yiW0CPjQWenHto0WviXdSDTQBM
 VGhYchcmBVrO9NK/XHMCBXhbBjxlUtpGRDYmWlJhtZguAo6tg6cTUpbFDPJcDQ5gjbOGacovYUG
 fvQV6eENE29hT5ky+S6xxilJ3KdAoHLkA+76OCaGyd/L6diUaIsof7KpuGw==
X-Gm-Gg: AZFdTZfiDCRIamiC83V5/A8dlF4EmTuQmlbYGT2K34swdrpKuwOjRRHaKl/xCQVjm8Q
 8wGlobRGtZmmjXLVX52R7pX0WitCrcdKJh0PTqdBR80gR9OvIN0eBOZzfE8OpLDYCddqxUABZ+a
 KWKZUyNnLJ/V9bdp2hlcqEWC9/CSh+pOHwhVyCAL686jOwitcV7XBOE9xhKODUOI1HvMIjFgXm4
 bFEo8LbQaL8RO/TfjJoEq06hZCPa0BCJgGxcmWAy1NFqbTC0DLDlL2PA92Tc30rRnEVTd0NJxGc
 yEan9T1MrPmOWuCqfM8qscOYjGiDJ/Yf7P1PvzvNdnjAYUcvDPOfcRmetE7WmiwbzwDSW4Grilw
 eGvdIGTTczQPdpPCHUnIkhKklgDSNEr1EjCG48qUVjSYxiRVGnGSzPMcEYxfVbNhksS4OIyfYAj
 UOcjEMFfkaqMFY4fXc+eNp0bodWvivh6wQq2PGQ1d0q2A=
X-Received: by 2002:a05:7300:c00f:10b0:381:1eb7:938e with SMTP id
 5a478bee46e88-3856c9a61c1mr15188637eec.4.1795457216343; 
 Mon, 23 Nov 2026 10:06:56 -0800 (PST)
X-Received: by 2002:a05:7300:c00f:10b0:381:1eb7:938e with SMTP id
 5a478bee46e88-3856c9a61c1mr15188607eec.4.1795457215816; 
 Mon, 23 Nov 2026 10:06:55 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-38567abb870sm31642823eec.25.2026.11.23.10.06.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 10:06:55 -0800 (PST)
Message-ID: <c64c3c72-ce3f-4163-a8a8-bf655391c10c@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 10:06:54 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.2 v2 10/12] tests/tcg/hexagon: packet and COF
 corner cases
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20261120182031.560481-1-brian.cain@oss.qualcomm.com>
 <20261120182031.560481-11-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120182031.560481-11-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfX44fc09Wtx/M/
 o05T8CYq7iCPlqJpXT/Jd5OIYSpTLWSJj4arTjyUWps3go0mHdEKYUaZrUjJKpHhVYIy9rTTHni
 HZNWHiwY31ABhCo2yrFq0KOydpTdEVg=
X-Proofpoint-GUID: QGTDfjpAXW-48_slrwg2XCp0XKLZzaGa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3MiBTYWx0ZWRfX3TeQIv+fX4Ml
 eLryBRWlZyWiE5yxk0gJAU3fjlXM68BWe8bBsdnIv8TotYsONqNtwWo8z2H5Hm1iTGhQRklEi5H
 upx8v6Ni7Tl1LpBHLoIpfrxmPj6AfeYsT6eKdIx4+a60SFCxdXLId5VMmMVW15ZTeOs5fuZt69J
 44cbaNRV1SDWpje7FX5UzeJeVFhBRjnx6m8Ew5w7x1wq6hToFwDfFjhlmJUYlrxuWlKqYCduEQy
 0kUukbrIMdvnE7r9lMMnrvn+q3/QChUIT5Z7pIEh+gaqbkE+LsyY0LZT+cAvZG/GgJxAekFa+OK
 qYicTY/uk1k8yTGSaL2jcbae0KW9lClX4aBOn5bMAETy9zxNrUqWU404nFzpY4QVVTFSOhtvefD
 JnfICjRXaSgH1VSlTPyBBJ3JTjBc8QMv/NDPu9T4mcV+1R6eVeAMq+E4DVtTFGSx5cNaL06vNod
 snP5CrPN3emhbzI7miA==
X-Proofpoint-ORIG-GUID: QGTDfjpAXW-48_slrwg2XCp0XKLZzaGa
X-Authority-Analysis: v=2.4 cv=cpIOAF4i c=1 sm=1 tr=0 ts=6b0480c1 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=KCCTKDjgE-A8CiVSvIIA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230072
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
> Add tests for subtle packet semantics not yet covered:
> 
> - Register, pair and half-register writes commit together, so parallel
>   reads see the old values; .new store data may come from an extended
>   or load producer.
> - Packed pred reads see the old bytes, auto-and before .new
> - Aliasing stores, cancelled ld/st does not postinc
> - Dual jumps, callr through LR, an overwritten jumpr target, and short
>   sp3loop0 loops
> - M0, CS0 and M1 updates in a circ/brev packet apply to later packets
>   only, and a saturating add reads the old USR.OVF before setting it.
> 
> Link: https://lore.kernel.org/qemu-devel/20261117183629.2002840-4-marco.liebel@oss.qualcomm.com/
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/brev.c             | 25 ++++++++
>  tests/tcg/hexagon/circ.c             | 42 ++++++++++++
>  tests/tcg/hexagon/dual_stores.c      | 34 ++++++++++
>  tests/tcg/hexagon/mem_noshuf.c       | 58 +++++++++++++----
>  tests/tcg/hexagon/preg_alias.c       | 58 +++++++++++++++++
>  tests/tcg/hexagon/test_cond_branch.c | 95 ++++++++++++++++++++++++++++
>  tests/tcg/hexagon/usr.c              | 33 ++++++++++
>  tests/tcg/hexagon/test_dotnew.S      | 34 +++++++++-
>  tests/tcg/hexagon/test_packet.S      | 46 +++++++++++++-
>  9 files changed, 412 insertions(+), 13 deletions(-)
> 

Should be split, ideally in its own series, with details per patch to
explain what each new test does.

Regards,
Pierrick

