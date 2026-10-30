Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B526606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 17:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=W2DK/quF;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=aJl2mLNh
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMqmE-0004mt-QU; Fri, 30 Oct 2026 13:52:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqmC-0004mR-CD
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:52:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMqmA-0007kc-Es
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 13:52:28 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UES8El1954224
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:52:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7pLKyWVgcqMUkLVgYhwHA12QIMQI9Ro+cIPPYLxSpF8=; b=W2DK/quFrNowPkMC
 Lsena+THvoCg6gjNzHCokePHdmdzLAxeprstND6bpWHVDQlxuRRepCyWoXC3NMFj
 pis/DhGBx2j4P4FgTpM0NwBvIx9YP1qZTaqb4ibqlIcRUFgKwkijtaoRvyY6gBqh
 DRZgKUg89NzZfTy6OxfRLJ6n6pRN9XxBoVxUwiucKJVWDuWDps/lVWYmy+m8XqNp
 mOIKchMxVZv5+Mu2CjAdjKfK6W9S/JcCTJYlxGsquUT8RJmF5pST0KKFSbUU1iXr
 O3QY3ARWafIeGaoK9/xjlPzigzFnPCWdvYOJdvEWxU5LH38J3cDcU9JuSIhk6Boo
 lltMoA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6pmaw1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 17:52:24 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3698bd5392cso854171eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 10:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793382744; x=1793987544; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7pLKyWVgcqMUkLVgYhwHA12QIMQI9Ro+cIPPYLxSpF8=;
 b=aJl2mLNhMQeVhDDDQ0f1eUHqYrPaCtbbIe3H5+Hx+uT9ZPT0kkgOD85D//9BT9nZXK
 87Vw6ssCdVT9DcEBSZPxvw7gS67cTRXLSL5u0WYvJajOPXMSyiK5yLw//IM3sN3vIn7D
 2qBHwwgztWn64aByHNAtKDggaaqbWi4jAThQz2CZAfPCihxE3CLwSMISSCet9mBYzblH
 NHWpnhlHts8hguKoywT3JlItnNrq1dbwfPWWEpUjacN7FAJ4q5sIfceIZc0IVBuhxptQ
 R/9U2Csc7pexrIv6K0aqUueAYXKtOeUGjjTF6w0ZJoQYqCDJbR/RJx9q/bYP/BEdvbKF
 A31w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793382744; x=1793987544;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7pLKyWVgcqMUkLVgYhwHA12QIMQI9Ro+cIPPYLxSpF8=;
 b=RXe/n6BqB6YOMj00c9m3ydu8EmllUwVMz+cY5VOhn7SC7KWqFD0MBYHDf17l5/JmeP
 W5Ed7pdkBKR/yFUvJeaGjzwAq0fnDUSrlfBzOX4h6BKHRhdkTnZLJMWqCJx3E7knorFW
 6Wsbvx7zBl559cqul/Nf5NPlwAwR/KHbkzSgs8MB5qVPqu+9wactccGFjRq/HJ4qZBMG
 AvdIYKYaO36xE3++XRoKjGDoJAxt34/ntgVS5fwBt1rX8wSTJfIuolWloTRiv7Y9Icea
 i0R3MGfCVrwWs8fMa9EItQG9qMjBdJlQ1kv7bq4a8EhJ0fT8i67B1jpmueUWnHGXEPyS
 w/Tg==
X-Gm-Message-State: AFq9FYJiDWqfy50acFaebFvgszt37HPt6fHS8yhBDFA0EwsoOBZGa4gi
 hG4/IQnJtnz0CcUayLuZPFd3bALIfplqvoZT7HHmLwWHWCpiqcREw+b6MwU+5JFrXLtNMEjVPyG
 G6qdjIRipnmVFZilG7KlNMyiBFjD/cAb390l6hlLva3rTJVOjWT43oVyaPvn/SXy5sw==
X-Gm-Gg: AYBFou167BmwDfNYH2oMsNyBX7yQpL6aw5nU5ydVrwQ0CPk+EOtT751QMdJZyKjT87a
 8Z7/VE3bNfGp6mgQKyreR2zkoGlercWRrMNXXiNgK93Y5XDXr9kuLENydDPzuEi5h8b4fjfT8w1
 Ks89re108ocMZZhAujkfMuycba/FMQEtaNSTRS1JY9mf4M4pyrFfHpDlUVYO6WtEQByG5WjW8XQ
 uziJtJ8102YpqFiYxvJ8TfIwrYz8j4UfQ59MPactrwAPpUkCU+PAQJqGCshnKxqTnZBwECJfEXm
 PIhdOzW1uillvFOf189ZtnA8QmiFthx71wLiFU3eP5thsv4DLZNeEBsw6WxA56Zv9eDuyYwdiK0
 Cndtn+WFe6FywHOnQ/0EA9II+HuqutVUy6tLKHvkWsD83nj+/LUAalJ0VXDAt0BtetZIqp/Hom9
 bYXLZ3CL9JGKB0AJU09W9gaqTiZSVaRphdYWIQu76J6+o=
X-Received: by 2002:a05:7301:4d12:b0:369:dc59:7a6f with SMTP id
 5a478bee46e88-36a422042d2mr3991020eec.1.1793382743724; 
 Fri, 30 Oct 2026 10:52:23 -0700 (PDT)
X-Received: by 2002:a05:7301:4d12:b0:369:dc59:7a6f with SMTP id
 5a478bee46e88-36a422042d2mr3990989eec.1.1793382743056; 
 Fri, 30 Oct 2026 10:52:23 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a428ecb61sm7754428eec.10.2026.10.30.10.52.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 10:52:22 -0700 (PDT)
Message-ID: <d27d8f04-5362-44da-af2b-4021722f7f3e@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 09:52:21 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/2] releases: build and run any QEMU release easily!
To: qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, peterx@redhat.com, 
 Fabiano Rosas <farosas@suse.de>, mjt@tls.msk.ru,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261029000853.15166-1-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfX6olN1dgvg4rV
 zzO89yCn1Jm14e72tMkYIPL3arxSL0U/rPBhD9+1oPgRH2Wvl3KrLivzmxC/MGu0dWC8R+hzwYi
 vRo5Yul7Zzc8zIhzSu10t5wD40P46Uv5JSouAtiwJdw0Ou8Ps0AMVAm2zWWcgKyvZX1YeWLqweK
 yfVglqWWsJ/+WhN6uMDKDtYvW20sg1MpNEoraauTy+iTN5JN5e0Mf3QNQJYfd3BhdneqGpt78aj
 XHcdO8c5hdlnRiXiDHAqGhDWnhnMbfyNh4jMZfMbk+k/LN05dCSIYGgnnmoe9fjhkUFK0tb7HRK
 UkODgoXNHoup6mhqt7jl6ztqqSq5I8cI6t/6WNDDIlbWaWWgddSxG2hzSszv8AEc0lR59odnTzu
 p0md3u1D3kl41FVeHvJD/w/V/mzY5VnZVtJPGGcSzbsWsyevTJ+YCR4g0XOlgAIyB4b0UTZQd0P
 cfUvSLIPqn6udX+Wilw==
X-Proofpoint-ORIG-GUID: 8TkR64US-M5oVgOTBtDlu8aNwX8pyndy
X-Proofpoint-GUID: 8TkR64US-M5oVgOTBtDlu8aNwX8pyndy
X-Authority-Analysis: v=2.4 cv=AJ83otAg c=1 sm=1 tr=0 ts=6ae4d958 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=HcjIUGKs2DahF9jiNQQA:9 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA3MSBTYWx0ZWRfXzfbN2FZPxo1B
 9Zhy8l06D8UGL6TUo4viSiBTw0T3UvrDvNvWN2+7aNonAVlx2/K0KrBeHf05mWhv0bILAMqAcG2
 Q+0rbKsYzK3lfgqu30GcDIXWzCfsGHg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 bulkscore=0 phishscore=0 malwarescore=0
 lowpriorityscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300071
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

On 10/28/2026 4:08 PM, Pierrick Bouvier wrote:
> This series was inspired by a recent post from Fabiano to provide container
> images for migration tests:
> https://lore.kernel.org/qemu-devel/24d04a1f-344d-4b90-a307-b582dd9a1128@oss.qualcomm.com/T/#m353f119dc1a24fa437dde8a96d1891629e64303c
> 
> The idea to be able to build and run any QEMU (past) release with containers was
> in my mind for some time, so I gave it a shot. Finally, it was easier than
> expected to obtain a single dockerfile (with a few hacks) that works over all
> our releases.
> 
> Images have the absolute minimal content possible. It's only qemu binaries,
> artifacts (roms, keymap, ...), and libraries. There is no shell or any other
> tool included. As a result, images have a size from 581MB (v3.1.0) to 1.1GB
> (v11.1.2).
> 
> This series adds:
> - a unique dockerfile to build any QEMU release. User has to provide an explicit
>   Ubuntu version when building a given QEMU version.
> - A script build_release_container.sh which automatically detects which ubuntu
>   version a given release should be buildable on (based on date). It works
>   great, and the heuristic works for all our versions.
> 
> TLDR:
> $ ./scripts/build_release_container.sh v3.1.0
> $ podman run -it --rm qemu/v3.1.0 qemu-system-arm --version
> 
> v5
> --
> 
> - fix build with docker (missing context)
> 
> v4
> --
> 
> - supports build for any version (tag or sha-1)
> - adds an optional parameter to build_release_container.sh to use an alternative
>   URL for QEMU repo
> - simplified Dockerfile by supporting any version >= 3.1.0.
> - removed patch 3 generating wrappers to published docker images
> 
> v3
> --
> 
> - extend dockerfile to support ubuntu 12.04, and lower older revision we can
>   build from v1.6.1 to v0.12.0.
> 
> v2
> --
> 
> - fix generate_release_links.sh: was missing userns option for podman
> - dockerfile: cleanup "|| true" and replaced with proper ifs
> 
> Pierrick Bouvier (2):
>   tests/docker/dockerfiles: add release.docker
>   scripts: add build_release_container.sh
> 
>  scripts/build_release_container.sh      | 63 +++++++++++++++++++++++++
>  tests/docker/dockerfiles/release.docker | 48 +++++++++++++++++++
>  2 files changed, 111 insertions(+)
>  create mode 100755 scripts/build_release_container.sh
>  create mode 100644 tests/docker/dockerfiles/release.docker
> 

This was merged into master (61436f5ff1c4e5ee8f60fa1a37962a60f73ea7a4).

Regards,
Pierrick

