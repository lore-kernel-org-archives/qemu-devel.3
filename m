Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF06CC44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 17:35:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlrsT-0003Mv-Fx; Mon, 20 Jul 2026 13:34:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlrrI-0002Wn-O5
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:32:56 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wlrrF-0001VZ-Ml
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 13:32:52 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KH6hGB3216130
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:32:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 KiA2FM7sVk1xjtpUGBPdyptqQ0er2mcZoVGCN8mLMuk=; b=IWTjYJgEgxEFdSSG
 D9OCu9Um9O1kARynLzJuMsWUuwwOpH22sjA6x4l7qV92OxASovQFmNJizl0iFI0p
 VbfsUIOAAQ093o+daDrZ+gKnp91rg56SGTOEDYZ2AZYv81b/Gk4+dUFGhrfNu3Xc
 O3kRhmOwi+8e3rpp0DCtyzCqkLL4RbB6nF5GxVnOl0XAoTMc1pUdTw8RyS8XOzcN
 9Z5gEO5yL2cJoIfWVQsCrMKXGzsZPtHTSOhc4LxF1FckKy8bI1dAzxe+cv+EmnMU
 qbPz9Mwb858QNupxSlm7sRS8OiCePahQM35zvSFJdN3tXPjit6c1NgVTZ9a7uy8K
 hIKAsw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fhk2f9mym-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 17:32:45 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c9151bf6ce7so11410131a12.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 10:32:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784568764; x=1785173564; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=KiA2FM7sVk1xjtpUGBPdyptqQ0er2mcZoVGCN8mLMuk=;
 b=ZmhTB64nOQ3Ug103IQodR0fmQumRC5PbqLCWonVh10uK3l4kBu+ODhQXktB5HFLusx
 RSADG6KGI8Irm1cIJlBiU53yVqJWp+59oPm1mw+P3y7TvZFxrBZTlrQkrYtARkG8ysNq
 UQd9Rwaj8zG/TFRbQklg9a+pvIf51SDcRw4P7SDPi6d8M+Dbfw6CfdZfaHK5LrEgdrJ7
 JCCs1HVaQ+7lVtOuA9XK8oPgmEQNj5z0zQ8mSH32ZfU9rrwMOq4qj9RuSSLDhIY51iic
 kDsKRIOt/VgNltiX9Dcy5AU1sQdOfluCdlXOJrhaL0iA5VbU4BmvwIrelg8uo9LYOsGG
 v2pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784568764; x=1785173564;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KiA2FM7sVk1xjtpUGBPdyptqQ0er2mcZoVGCN8mLMuk=;
 b=hqM8oqr7WlCR6XcUlkZ7YXmou9GV3cMQyi74m/zZvAtXmJnTPdzn18Ej4WhEoEvZM3
 n3tMXETWqkjSSmY/ZBUYePIeabvm+ZZxiqU0tJu5AzKRENKtYjvQHg4NnwnzlNlez2ht
 5cfpj+DNU5GUj8RhBHvmGnQHaGkG1ja+f9kHw11BCnOfgR6hY6LoXeXAOu+Lt/L6eE+g
 Rfc7las6g4Gy5DKvhvvNaI/G6abFP5G3TFLTu98A5LINdqd4bMk8l1yYaRcKzO6sqUPx
 4BjTmBcMzrU+j0uyA88zhbRDzPvkyUSO2TLsqbfTuFSWUJrP1QFPnib67W6XvCj/J6Cd
 /22g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrs+rpMtocwtae9zmvqzw2ztSxsCEzfcLEUCBRjsHUcgpWhMqsSCfEgUzBjJ7h8Vy2lM2BjpVxqOsn8@nongnu.org
X-Gm-Message-State: AOJu0YyGZDonfu99hF6/AeKs2kO9yAuAas9OSzocufDLjFIeRHdQpYBp
 jiFo1UQLrBd/6wgKZdIt9mrv3DhMjBWH3ohT38OzAYrt3NfmXGB4gna0TbQksEklzNy00CGiKjv
 oyjx+3KvW4RAMB0+xyq9GJEAYeVQzpHrRfKcYg/p0OzVbhUBl5dV/mCneWg==
X-Gm-Gg: AfdE7clOKF6hihWAIb1IEVrFD1rNFqKQ+gbjG47yxDne6sCErd9PRs4l2ksifF0YGKn
 XIEIO99q9qri+u/etAI4CgEoQVJn/SujHt7fKY/Ue6wIdpnxZkiA7A2FtnArkEYbL048X+88rbw
 9axG+Q/dSLL41zSY+XcURpn87Yj/5ynH+jSwLwBHwU6iLQOf7znQgz3UpLpFDUKvYjNKWITNxz/
 ueMYok1dQIAasMeQcTaX2CT4TuCz6AMtipTFxXRrEslgBF9goWlM4ROp3HQo8ZrjWUhzj9/Xayl
 UVhHSQT54YX4DuEguWXhWuDUFrJfmxZR9jJS9BMUDgMILW8sM8mzbG26kuoSzqsThVpkG6h/3vZ
 0dDcVW6inQdH++1vbs130k4TDxW6Mbs4yHjj1cXozQKNah4rrzoCk2Akwy31PuI+Y3sD4
X-Received: by 2002:a05:6a20:9148:b0:3b4:b2d7:c146 with SMTP id
 adf61e73a8af0-3c3ad64b745mr16593925637.21.1784568764490; 
 Mon, 20 Jul 2026 10:32:44 -0700 (PDT)
X-Received: by 2002:a05:6a20:9148:b0:3b4:b2d7:c146 with SMTP id
 adf61e73a8af0-3c3ad64b745mr16593894637.21.1784568763921; 
 Mon, 20 Jul 2026 10:32:43 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429fdbd45sm38830085eec.12.2026.07.20.10.32.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 10:32:43 -0700 (PDT)
Message-ID: <1e834791-1837-4c28-879d-63519d9054f4@oss.qualcomm.com>
Date: Mon, 20 Jul 2026 10:32:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tests/docker: ensure container command is probed at
 most once
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20260716102515.1503404-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260716102515.1503404-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: YzTNpUDFRwkTxAD4Kqxu6nz2KdEk2nNF
X-Authority-Analysis: v=2.4 cv=X8xi7mTe c=1 sm=1 tr=0 ts=6a5e5bbd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=20KFwNOVAAAA:8 a=VMQfhjUgHwDC8tgg_nwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX6iOhpPlQ9I18
 VBVTHRTajvu/O6xiEm/HWNCLGUSNzQCz2U7bvHDZ64IOLSd5siQYF8a7r6wTCzTmaJ0/keexnwb
 Z67K7VjD7YdKIWFA8Phh+5Iqs6M0fbw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE5MiBTYWx0ZWRfX/9duoqJQnOxe
 OvwixKq+gw7iCcSofbGhNMNQczw/iTEaBSIczhl7LRJG5N7n/N2GEVC3k7RX41o4GpbuZs+mzgO
 fob6/e00WOtduoZ3/VwWXvTOBBxRU/+GjmoUlEpSK9A04z30iXIkfhOF0+3eK+Wz6oi59LaNNHe
 FiLZVbxdrDyTBoK8HHd50bes2vPPOKmd4+yA3sIsz79zGSoBjENdZR1DD+JpONWuQ8QgXmxpIAf
 tEg77eRrQ8+fd9aNcn2vVzwYejQtTGeP3wr9+0Dy/fSe20Loot9jF2jHiTE5UdXXFaRdQcgrVAo
 kmTbabpqgTzNJGhGwaK7D21j/uQJlinwT+PWE+VbeIdhWPhKWn3HH+qPggwbweQKI6uVMI7eYbP
 f2L047Kj4S9z6VK4wz6d9Pp53NFGihRleat7c6zW0hrhnnfSyCB/5kVf58v5UDTlUroXGiO6kqL
 hZ4SL8BTQk97y7NaMHA==
X-Proofpoint-GUID: YzTNpUDFRwkTxAD4Kqxu6nz2KdEk2nNF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_04,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015 spamscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607200192
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/16/2026 3:25 AM, Daniel P. Berrangé wrote:
> The '--engine' arg accepts either 'podman' or 'docker', which is
> not sufficiently granular to map directly to a command. This
> means that  docker.py still has to then probe the exact command
> to use.
> 
> Meanwhile the 'probe' command prints out the full command to use
> but this cannot be passed back to docker.py to avoid probing
> again, so the caching is only useful in the few case where we
> run a container directly bypassing docker.py.
> 
> Address this by replacing --engine with --command for docker.py.
> 
> This in turn requires the --container-engine configure arg to be
> replaced with --container-command.
> 
> With these changes the container command is probed at most once
> during configure and never again, while running in an unconfigured
> tree will still probe on demand.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
> 
> In v3:
> 
>  - Avoid bashism when testing probe result
> 
>  configure                     | 25 +++++++------
>  tests/docker/Makefile.include | 13 ++++---
>  tests/docker/docker.py        | 67 ++++++++++++-----------------------
>  3 files changed, 40 insertions(+), 65 deletions(-)
> 

This was merged into master (43bf3a0ce969782c4394fabc94777ba880b3598d).
Thank you for your contribution!

Regards,
Pierrick

