Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E592606A332
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 23:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=PysTHH9H;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=YL74lVWX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPTCn-0002Gm-2U; Fri, 06 Nov 2026 18:18:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPTCj-0002F2-MH
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 18:18:41 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xPTCf-0006pv-RX
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 18:18:40 -0500
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A6Mo8fj3696177
 for <qemu-devel@nongnu.org>; Fri, 6 Nov 2026 23:18:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v26BQubwrkiC7Wl4LmtkImLv1TE9YkE5FaW7mgO1ST4=; b=PysTHH9HBL5QvQ3M
 pVcTK9YLlzBBNrkNoArtcWE7k5ygNRNuEn7Vrom5vGb90EuD1tMBqaIbiFZg7Bao
 CilFNbQprdHfdxfNhGfOJmKggfSwkMNnhTHnc5URNIIefL+Skm75bLvR9LJiQqjD
 42YzEwZ8fWEXvKNRF5oL4UXuYadIrFXmT1tS8rUJ+Vb5+Zu9rP7WmDXB1hW6jywH
 foM04IuHPha14ad0MwQ1TCu7llffXK5EeNGVTtfhd/IMtYeEMujcuysxmgwtp3xG
 LslMkgoDG6Uhrs/T+XnshwT9USMSse4GXBV4yKBByswDSK1F5+pR77NA0gLwSpxO
 +NtwuA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hsmyqrqse-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 23:18:36 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-36ecd5db581so3624770eec.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 15:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794007116; x=1794611916; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v26BQubwrkiC7Wl4LmtkImLv1TE9YkE5FaW7mgO1ST4=;
 b=YL74lVWXssnlBVYgAoeQiKzsYC8rjFKJC0xos4ehRGembLtNxzzLn+jFQVLAU6d5m5
 AWR/RutLgY3hefCN7FRvsNeqcHBTQoX7Em8djmJhiy1BY8XGidAswD1GYNs2iQdEh8jA
 3bAhJ3xabgCJN9HA9Qrrjti6D3ySRJWMNCEmbOrMXLXYHg2qWfex4HoVB5yL0zgNld74
 2V8ZFfs6/cGYw+zSiHJpVTssZQf7MDQOw7sOuhPNcVE1cJiMToe9dviBG8Czjv++u0S6
 4BfkULwIHQAn9inSWpmhq1bsqL4Fp6CkvjUfggV5rr+V3oFvJN18AySH574yvwZ00VQc
 8YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794007116; x=1794611916;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v26BQubwrkiC7Wl4LmtkImLv1TE9YkE5FaW7mgO1ST4=;
 b=sfufLwd67M5Z1YVHvFgMEHz7QxRhEeRV2m6qKRiOmeaQGOkxWL22Fm1EpLjh4a1knf
 UrovHnAti5DWJ5v4VSl5f++xBBie4eQVtcmgn2Fa5wCLieLcOD09cLUPbovneYPmd6Qm
 B0cOIaGfmXfZs8H4kca0VOOC8w8+f/A833uGoI4BkqzAVpUhogxSk8EgO5txITdpXq8A
 isiJ9pX/b95IcmUFsMKzZVYVL1khNyuZRirjVw7VpJsa2FDumXXk5HaCsUA1lyqwj3nB
 8WfuhicqjkIbcAcfqKrTJpFAQtkFLuPxTBJD8ncNj1YsbLG2El7E43hFWMaxA9c1HDgd
 lJfg==
X-Forwarded-Encrypted: i=1;
 AL+hErFIWVCc7kyrcH1seMRqQLki1ByraB269+eYACVVMhtmfVxpYeGW90sCxjAkmTUW8ep49gwtXQeM0I3u@nongnu.org
X-Gm-Message-State: APuU4Z99VrVkuQsFboWxMB4NyM9RnPsMvF6M21dPOlQ/tLFBUgLVpdzX
 iIyhUDWP9UP1LBItrrDqi9iG2XjRTkq0sAKDMeZUUiGyyL4axkB33Xy1q3SBPxfAa+2VsXGycfa
 wWh5E7o9yNOoyBmFcB7ndP68VRlKdZBo+baKnrKbtfOqpAUpyyJr2Hixwsyyj0m7QZw==
X-Gm-Gg: AYBFou17Uy5y+POmBNhEL9w2rAef/QPfO7mUX8Rlmc+GWQwaaKdLPsRCc1M3QB/Usie
 E6Qmtb+rSVDj0hsNqU1YUxwhIWzeh6KJFotBfgy94cG9mDygFJFwA33coa8I+Rshsj3KJvALMbR
 m/J+JT5oNKZ+lhVdHt9M9RkIPVcKOr0I2txu8AuXBM6KuCIgLp8F5EIYyFNt1wh/37lxbXMLKoG
 s40tBh+tOIJafWdONyEg0SC0nNEwj2iBfr2ZD+WwrM1CvO+gV04t2bxY+Os8lHSCosZmhu0+T6k
 8LO/EYEE1ylZy0osMvh+lxzeMHARVtM/F6S90fsXf1sZeeyfjtvvfwmiFrw9fD/gJDCgDkWcClS
 bRlo2CDIGHOSAGcA5dvr9tK1PidYRS2GXDDfTw8FUl61XqPmXkKmQ4rlmMQvC1oQQvpd8gyNkPB
 fH9zedZq56OFjdXeEB8z8WVLxJc5YBekfWqcDnic58oQ==
X-Received: by 2002:a05:693c:2110:b0:356:7ddb:2e54 with SMTP id
 5a478bee46e88-36f76c16579mr5851788eec.29.1794007115348; 
 Fri, 06 Nov 2026 15:18:35 -0800 (PST)
X-Received: by 2002:a05:693c:2110:b0:356:7ddb:2e54 with SMTP id
 5a478bee46e88-36f76c16579mr5851763eec.29.1794007114644; 
 Fri, 06 Nov 2026 15:18:34 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36fa922c6c7sm12058727eec.10.2026.11.06.15.18.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2026 15:18:34 -0800 (PST)
Message-ID: <8f2ce7ca-13b5-454e-81d6-eb45781c8fe2@oss.qualcomm.com>
Date: Fri, 6 Nov 2026 15:18:33 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] hw/misc: move vmlaunchupdate.c to system_ss
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20261106171836.2020151-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261106171836.2020151-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 40NUQ0tbb9GRghuOrcw2l9N25wfxczl1
X-Authority-Analysis: v=2.4 cv=aNZlOr9m c=1 sm=1 tr=0 ts=6aee604c cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=rvpNB-5ijmBcyfLEDXoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA5MiBTYWx0ZWRfXwjKBGwJAyQ14
 lBeXTq3ICsPoF38KJmg3URzWjpwEJZV2N+XkpM5xY9AJ4QhzcsvxWewxmaSw9PVjwDj3hy7N4IO
 16ZwoW5dPM83jTD2noGKtT0JEt7stMI=
X-Proofpoint-GUID: 40NUQ0tbb9GRghuOrcw2l9N25wfxczl1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA5MiBTYWx0ZWRfX7X68FFtXH+Tx
 rTpBW8w0rfqVJ0vup22aX2+YsIqQRE2J58eUjkrJ/0UjhMaTYB9Dyg8WruRJBoP9Xsru4K8vH/w
 UzPDGydCIb4HzJbj8Txrvghg64hEuYACGgGfxPJmnLW1vyMMqJ6seaCNVrgHqlOzxw3kcj2Ln8x
 lte6brmqw0W+jLaXbWnUMXFJvs9TwuhkyGnkqiSTE9JrSsFd/sj5J1PDkOgS9nhZVhXjcrInVp2
 ngdOL6XpRdsXJwDd4UmCKiNpK3+Z1/KRMpyE4zQQSsNzGSmi8d3mchbXRFgP/dyShn6LZhsq89U
 Cynwmi4ThZvU6YbU7ag5xVbVIbYgcNS4Mf855NrLSKLKpecCUlnSCnlcHyJMgy8DyV1iRY6lzXA
 DDIyh4RzvytZVl1GGttCK7RYoT2rO3s7bu7QMD1l6c+k8fYWR2PuXM5DT0Si8gwL2/nYMziwAim
 WvGZSkWJThnVrvfC5MQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015
 impostorscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060092
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/6/2026 9:18 AM, Daniel P. Berrangé wrote:
> If building with IGVM enabled and both arm-softmmu and
> aarch64-softmmu, test-multi-target breaks because the
> vm-launch-update QOM class is linked in twice and thus
> registered twice.
> 
> Daniel P. Berrangé (4):
>   hw/misc: move vmlaunchupdate.c from specific_ss to system_ss
>   tests/lcitool: add mips32r6el toolchain to refresh script
>   tests/docker: add igvm to Fedora container images
>   MAINTAINERS: fix typo in test-multi-target.c filename
> 
>  MAINTAINERS                                         | 2 +-
>  hw/misc/meson.build                                 | 2 +-
>  tests/docker/dockerfiles/fedora-rust-nightly.docker | 1 +
>  tests/docker/dockerfiles/fedora.docker              | 1 +
>  tests/lcitool/projects/qemu.yml                     | 1 +
>  tests/lcitool/refresh                               | 2 ++
>  6 files changed, 7 insertions(+), 2 deletions(-)
> 

This was merged into master (71f25c75417d31c214ba2cd26b273c114fc99987).
Thank you for your contribution!

Regards,
Pierrick

