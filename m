Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 343DFCD5BD1
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 16:46:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUSGE-0004PB-Ak; Tue, 02 Jun 2026 12:46:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUSFj-0004Dd-CX
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:46:12 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUSFg-00017A-Ho
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 12:46:05 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652GgoSA2691969
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 16:46:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 57o9Yb68BwtqoKYvW6vtM1uCXyhVWj3ykLsRZG+HF14=; b=NPMCcbCNjriC9c3u
 7BNkHPxK+518Q2gKCKvZlkjxGew+HMcExC/Df2ITJH8YAWR0Kl45fiLjKgcwe3Ug
 0eOYzVGy0HR7soyDGdnh21R3FUD23xs+0E5tB+hdhF92KVCC6JHEC5tyuQbXd+yZ
 E++V2QFsAgVGlIPwr8Fu5O2c+YtyO5tN4rpCcYyBc3u+w/KxgArHP0dw30LZZJ5D
 fqGjr8GWRYFA02AnkT9hLipFD+3x1pyqamcg16W96PSQiOOcLCjNvu4h6Vh7H27Y
 vPGz46XD42uUAEwolJnWBDdgLyHBuoOX8npS8YnDALzDRAmr0Hujvn6T8UVPScO3
 DNRcHA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehqumk308-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 16:46:03 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ea42b025so2121481eec.0
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 09:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780418762; x=1781023562; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=57o9Yb68BwtqoKYvW6vtM1uCXyhVWj3ykLsRZG+HF14=;
 b=NsnvFBBg+zalG9zp+KLQS8NjDmOqYeVwcLwPVts6eIK9tS7qfvUxm5u7Hk9nvV3aB9
 Dpn0enf16EuV1xGH0o4Hi+LHJaApaAynGMlMLbPvmxLAJRRY/eH7jICINlNXZK6fQk+W
 Si47Fy4IuXgd/dGT9aDhdzHn3ZOz51gxCGX13t9u6QDrQVR/oCxynKCOkblmgMLGgNrP
 ya98uuYECiXgSuUumBAPYuG0PlLhh6WwcTHTH1TNUw17xdg2hb5KIQ0xhK8rrOyhFiBx
 aUNMXPaIIlGOOCOMhNZyTc3OOD/0PsHIKxQfpow0+1QEGu2N7ueMHwiDlyG3lf6ppe+Q
 qKJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780418762; x=1781023562;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=57o9Yb68BwtqoKYvW6vtM1uCXyhVWj3ykLsRZG+HF14=;
 b=kld9EkFD9XxhiFZ3Fjn0EwG+GO9PIOip2pXskAcwnP/DjRD2p+RzbBUrScOxhKYJ4j
 p30jkbV/W4dR5qqu+LpTVAgCBHw17haAfOJUjC7zXa1oYJfTtyzefvJmfbrTWA2BH0zd
 r7hcNwLqHqvhyFe0XeOT2conHtGqu3QQ0vFceWwlgnfJu0Gff7Oq7GP4hX5PrZUDqwNT
 GAgW+fssJQ5i7q16CHxRKzlkxqQdda0wZWRLB1LOdzXSZVJq1sxRmJk8CKXm/BQ0qKFm
 +zx9XfYMnyNTaxT3kjjP6gfukREVBx7yiXoUBEjsIiZdDMyS1ZCe+bRmU2VeePbctBcT
 S/xA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/FQEtBmapporUGeiTOHDPT7eeYUl2vYQSH42HboLiMXNGkQqmxXzbYsdSGdmmn8xzko1Cr5c6khyzY@nongnu.org
X-Gm-Message-State: AOJu0YyCeo7c5W2FEWa+jnVBAGKRzDPUZnt+hg+fvBCX/7uLEFGVWk84
 sVHpJwOwQQbQcGW9SDf6ioA7IxwFgqDtlzOGCxYDUwLNF069h/0lT0bT6GGBf7b2iJm0B8lOzZq
 EAWz8AWmudPZVyN81qORxA8jUwxhZi2fVepQzm3RmDZYiZLcWdG2J/CNY9Q==
X-Gm-Gg: Acq92OEh6MUmVpIxCvCKNrlft3ssGdfhbm1mpvyluWGpeOY2UKYxNC7v3VuFcCfCuzM
 KMt+m+pNdUkwjwCU1Tan+9YroJ/y3I4ZhDn3FMm0ZEO6LWoaaJsxv7mcYIk4DPxDalFyymbtmbK
 RTkUnAjlUIVD0Z0YqhdGz7dHrMn24XuLoG2syqlJwX4RNCEonfHP7nnFJNewT0wYByNpT5ZuFmX
 NDjDXr4VvQkbetsOWdZpoJ8vHEJ5dGxzZJvkZqCAzoJMbp/GnjnTRGd8GnMIjKCaMV39pQbknET
 GekG9T7N6NcQYTuKCnBg6ZMDuOvHAbI3aJ7O8s3Y6P30AeKekeJthX0/Ayn1m8QzhCG9RRXqXFk
 yGf+s5xgj4Nbkk7zqbGIJTUguNs5GFgMAlbppkWZuMqBSRUI82qVAcsLlqzITSa8Rvrd50rs0k5
 kVq5c/SuIx3Et+cv/ayzqA7G2z
X-Received: by 2002:a05:693c:2294:b0:304:81b6:fd51 with SMTP id
 5a478bee46e88-30734a8b867mr2444988eec.6.1780418762260; 
 Tue, 02 Jun 2026 09:46:02 -0700 (PDT)
X-Received: by 2002:a05:693c:2294:b0:304:81b6:fd51 with SMTP id
 5a478bee46e88-30734a8b867mr2444971eec.6.1780418761765; 
 Tue, 02 Jun 2026 09:46:01 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-137f556049csm156786c88.15.2026.06.02.09.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 09:46:01 -0700 (PDT)
Message-ID: <73aec634-11af-49b6-92b0-2a5355590eba@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 09:46:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] MAINTAINERS: remove stale Cirrus macOS build job path
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Li-Wen Hsu <lwhsu@freebsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>, Warner Losh <imp@bsdimp.com>
References: <20260602162457.828969-1-stefanha@redhat.com>
 <20260602162457.828969-4-stefanha@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260602162457.828969-4-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE2MSBTYWx0ZWRfX8+j2z/Xt0XXJ
 JuWjQMQ//S0+tt2ylGA1Gnwyw+VOZbOvha+Tr+qBBnXnTUO2iEp3BgLb9bTdMvdQf35vHMDIp63
 LV33RKvTzMSjxNqqXtlmhLW5SwYsEk36bHcS/O5edbeI5y5hWZJxdUiQbFoPw/HpfMFZHt5QBvF
 ZfO4e8/jZ3MFjT+fIUVqR4f3ZZtLF9E3lbP8rSey9OXZgyNjhGAFz/t4EY+vNQpqrEHgCxBhLRE
 Pry/N5qdwQHLRPa8uuG3XccfT/ZqAVWiyv55odsq++KUMghJYbUXMUmsOjzwv2CDggJ+TYMaoh2
 eDYHKQfufTK9Qchjc6RdHAPxekfAMD/gD0TGRZQEi4KKEGZRBwZ1raMkfO4hvJgxaRTbmX0iUSu
 yBzUEZgvHy6/ZXtAs6EAeWQGNXN8gAltMQtyKdKNgaqJ6xRjnavesMsOE8So4awgZ3Q83iU77nc
 hsgZOmjVZnD5EPenLmA==
X-Proofpoint-ORIG-GUID: 0eIL9GZd0m1r9fgHx0ioHWJpMcjtqKDm
X-Proofpoint-GUID: 0eIL9GZd0m1r9fgHx0ioHWJpMcjtqKDm
X-Authority-Analysis: v=2.4 cv=Rrv16imK c=1 sm=1 tr=0 ts=6a1f08cb cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ttX-DzhIOh4QrhBK5IwA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 suspectscore=0 impostorscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020161
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

On 6/2/2026 9:24 AM, Stefan Hajnoczi wrote:
> Commit 984b192bdf37 ("ci: drop cirrus MacOS build") removed the Cirrus
> macOS build job. The MAINTAINERS file now contains a stale path that
> should be removed.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  MAINTAINERS | 1 -
>  1 file changed, 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

