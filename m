Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CFE1C43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 21:16:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgqfL-0000io-Hq; Mon, 06 Jul 2026 17:15:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgqfJ-0000cx-7z
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:15:45 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wgqfH-0004zz-2Y
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 17:15:44 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666KE5A91428858
 for <qemu-devel@nongnu.org>; Mon, 6 Jul 2026 21:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7J360fr0h2cquQi8sYQEPhrVWL1/GVFYapo2HnFl984=; b=lib/EDVkic1XrskQ
 zqJHlU1KNL3iHp/8/chgNvxzAUo9VJb8Z4wBr4LzHOjhAdQHacGgjGu2bFip1+Je
 er6nKkt9EAEz6gFVru/qceVrSgbRThHVficwG6zDoDmfwZZq6tZB9r5Jg5iXrMDD
 RgxZ5ayxRosrzFSpdXnD6XGU86UsTt5DuC9E7qV9LpGFXOIhxCMJ5g4Azn504Ei1
 JNL2etiaZJA/zTaKD7RUoBwogDCXKJ3AqJX3IiSL+oss96lSZ0NmVZjDh38W9k8j
 AY33dRSfT89kmua9RFlQ8xuBSaDlBC0WWV1/TT7jqryzyYG+gwqoc3NO0IEtM6RD
 r4JcEQ==
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f87rxujg8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 21:15:41 +0000 (GMT)
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-847ad67cc51so3477898b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2026 14:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783372541; x=1783977341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7J360fr0h2cquQi8sYQEPhrVWL1/GVFYapo2HnFl984=;
 b=gfZsuy/JwEG08lHKP0VqlJF5JwZMKmevb5Od1SAO4tp9xbzSi2+gQfJCrFWUAIxunJ
 6SZueAx5PCBXODzVrN/10uKcjba6Tztyp99f0ZAlihPrQHSpYCaZvVv9vQv8Hn6K8n1u
 lT+T1FWd832ttU8hh1z0QQPdUQi+frJ0vTefixTINRF/OsxaOSOWbgCZY+ckZY2KJbc0
 BXrr7Od7SJ88quq/ni6IJaYiW+cP3Eavgvj9/yi23HfhTBCtFI9ESL7oUVYGgQu14mIp
 1TKkn5Q28YevXRqTLMIYMHpC6DCZAlNvAXF+RfxemdG6WXcL9F/bOKkR1wGtGqlfM4zV
 5JwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783372541; x=1783977341;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7J360fr0h2cquQi8sYQEPhrVWL1/GVFYapo2HnFl984=;
 b=Z1bl/vhPeGDQ+VKiVwGjAlbfBYjeAJ7gz77IA2V4dK4TBwbBexw06bI+CrZZbSVEjj
 5o5H6l1cIr2penOg8hl1UHLUJa4ws5I97wTlIevNwbMWKBGultlSppqo6YTud02sPMaG
 InTZR69GaewaxwSDjWe6wSAAvxyyuiVCa6y21SH7B+7L8M0pVC6fOBQojP4aU53sPsDA
 vU6FQ7ZG1uLtWK9H50GnkYvjWaCdFHcgxfYCPZsFoZhqjjI5XMKcqNTSqQa7lI5faG5j
 N6LPC6Bra/9WD4fwdsPgKA8bbzmZXBTo0Q6SCrpXa5i0IQyjf/UFIqELAKh9VN00O7mI
 M7eQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro2XtKzv0rFu7XvjTf8tN40ammCd/amYj1Bb7TQoXzatgh0EzJMJtVPjrWxPBx1/FpZgBvUM79Hb+gT@nongnu.org
X-Gm-Message-State: AOJu0YzIYia0UwECC84enehBdYA1RKLSUujBPG4rRVWOnrQaLS7R4UFQ
 rS6w6ygPMpZSdXa5DXT4mIb7XDjCSEO54EW5vL284yeqnnMTlF8EDy98AcRStwuYDhY8nxWEVGB
 RTjyOn7x+xHz+HXzsQKeBey0+Px1dP7jlHZ2auCgErdcUIex5Vj3wFV28yw==
X-Gm-Gg: AfdE7clvSTu2m2sPbaeVWA3RgJbfsiJ+GzFqT9Bn3IwBxqDyV+Bq0uRHO/tvbnfoIDZ
 7k7745D8Qp4N4EHinKBFsJXxZO3sNiyXzdTUYWpEyCkuTP+Nvn1Y9Z9pbizitN30UINB1w9iXPU
 MJf9dnStyN/8gXg7zUAsSpXZQxqTLZpsbbcUnaPAsKudiUyemdU+RhfRvFwCf/fFhOUIXMvNprY
 xwLp5ziT3wVQSTn/DPUFPVg1eqNg0AYAqT58x8sU6P4Eym82fvqBH5ZZF64I6G+UE7fSITTwjKe
 VTUTbh+wVDDjVDq528ijnWmpcMR9tTHRLl7W0G89J2yycQZgWsjrBvvgGn2xszl9i9pj8049H/j
 kuowfjJy/JO+I5fm0EqUaZZF8y/4jiHOa6cluMa1tPBlGFAv7XMb4udwjYA8NUji39pWkbVkjX5
 lIZZ0=
X-Received: by 2002:a05:6a21:b85:b0:3bf:9cbd:9a36 with SMTP id
 adf61e73a8af0-3c08ed94fc8mr3105127637.26.1783372540489; 
 Mon, 06 Jul 2026 14:15:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:b85:b0:3bf:9cbd:9a36 with SMTP id
 adf61e73a8af0-3c08ed94fc8mr3105091637.26.1783372540020; 
 Mon, 06 Jul 2026 14:15:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31174a56d4dsm371510eec.14.2026.07.06.14.15.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 Jul 2026 14:15:39 -0700 (PDT)
Message-ID: <9cc6ae91-9379-4469-8109-f3aed3f0f4b1@oss.qualcomm.com>
Date: Mon, 6 Jul 2026 14:15:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/9p: reduce xattr size to 1k
To: Christian Schoenebeck <qemu_oss@crudebyte.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>
References: <E1wffqw-001Sc8-I9@kylie.crudebyte.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <E1wffqw-001Sc8-I9@kylie.crudebyte.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: rDugSTBva_XYShHB0PLdrlcJ_BTL9WHN
X-Authority-Analysis: v=2.4 cv=Hv1G3UTS c=1 sm=1 tr=0 ts=6a4c1afd cx=c_pps
 a=mDZGXZTwRPZaeRUbqKGCBw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=K92WTf5yAAAA:8 a=STDx42bSIwQV5gvF0D0A:9 a=QEXdDO2ut3YA:10
 a=zc0IvFSfCIW2DFIPzwfm:22 a=X9ok8FpLfHEzVMsE4qxm:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfXy+3nQePx2lOI
 v/hFb2QLLmyrFx3kxFPuUEfagW9R8AU97w5VqBSVy/Wu0bbbm7AX1q68KgATaRcqjhCp1IbaDdr
 FDA9ItbTVV0+h6n7sjeKt4ShCJGL3Mg=
X-Proofpoint-GUID: rDugSTBva_XYShHB0PLdrlcJ_BTL9WHN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDIxNCBTYWx0ZWRfXzMD9rJv5XFwP
 9FnQsDp2082X0YJoBOJa5Qz7X1xh9ElPL/l2npG9Fr294rVDgXnlm76WV7wH7IPGm9E4pVmRoA7
 K66s1yusNCJALMP5XwJfaMt2SkSyIu4i+ulDe4Klz1+2SuIKe5m2Pq12MsXX0nyEIU8Zk40lxND
 sJnQhBqM20Y6XFwQVybUExU8eoY7TyLft4wrIg3Sn9u+8F6+Y3/O0UdSY0g2NPcpttYfgEMp47c
 WHhavSYb5GQTNpWgtHBbbQpTw4sypc67WZSj1ATevuTefRcxkqouGaIBvwOKiMUTVDGm4AvCkVr
 2+T06aSqzVPIlqXX1YTJemZtO0stTKLKpqaf2rvRUIKjmN6LhNLIlHM3nTrfeZxviE9AWuhDhCu
 e52wagHuGO5rlys9F1g7agzT3eUlK3cmyXbl3m76UBTphrno/BTHyvxOk3nWWrRuW++/qCWIVGy
 BDcSN7PNMliX0jmaaSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_03,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0 priorityscore=1501
 spamscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060214
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

On 7/3/2026 8:26 AM, Christian Schoenebeck wrote:
> On host systems with ext4 and ea_inode capability not enabled, the max. size
> for xattr values is slightly below 4k, which caused the new xattr tests to
> fail on such host systems.
> 
> Reduce the xattr size for our tests to 1k to prevent them to fail on such
> host systems.
> 
> Reported-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Fixes: 04a62cdfe8 ("tests/9p: add 3 xattr FID limit test cases (local fs driver)")
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 14 ++++++++++----
>  1 file changed, 10 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Tested-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Looks good for me, and fix the failure observed.
In case you want the test to be more complete, you may try to detect
ea_node presence, and adapt the size to it.

Regards,
Pierrick

