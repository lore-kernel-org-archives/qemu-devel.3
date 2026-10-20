Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45840606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 19:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=aDGqFWRz;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=Ya9KqRtD
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJFT4-0002C2-OU; Tue, 20 Oct 2026 15:25:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFT3-0002Bu-IN
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:25:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJFT1-0007wS-2U
 for qemu-devel@nongnu.org; Tue, 20 Oct 2026 15:25:49 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69KHSIPe836385
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:25:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wmPgVp0vJT8pZqZwkdbDsSNO23joFvpAThJO8aTHg5c=; b=aDGqFWRzhJUoGFN7
 nKo+7FPoCDg69B7UrlRPDssw6SBBc2z1gdPQopcic2wghxg44SBeeGRFnyxyEUN9
 vM6lZsBiwvXCPLFK6txm/p/txF+8Da8fBZ7u9b30rxWD0ZvR1Hsnb3C1HbPHD92a
 py/VIrghBuJbpGIsuzX7BcCwfdUJ99Yk6L1JZ9Apj0gtcTpYKZDMV5gXVMVP48tC
 ST7acH1G80OFiE9wRx2m+qHUs/+AAg1De/CJ+W5jSQ9A09sDaEjOZ0MWqsJ09Q2J
 WQ8GIic7SWgLoGZ54TADT9LqJvhHXsP8zSuHG9KhgC8nq1ndjHIp/GVq2ykBg38t
 oyziLA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4he7hv9s2v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 19:25:44 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-341eff9e381so10083284eec.1
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 12:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792524344; x=1793129144; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wmPgVp0vJT8pZqZwkdbDsSNO23joFvpAThJO8aTHg5c=;
 b=Ya9KqRtDzKqAFmKthqAykUGLyBrIS6bj209VeVVlh6czExHYiFvrfGS30CH93C76FE
 GJGpwdpnxcviWS9eHnEAuzvBSR1TjxLw5d6LCgKSCmBadj3zgusAQVIJJbWSCDAemO4C
 aiT6yY6XBHy+Wx+IMFH62ZwpotnIKdbHaslxAEBZ0kVUA4j8m20ynrcwVqcrQH/gFVHI
 avd9Kbc0IBJ+CT59AOXmfavhItnrHfBEFFoSX3Bx3+i3W4D9PFa8GbW8qg02w52o/F6m
 QzkiKCvPSKB+P+qYO7zwL0JCsGB6RjgS8oJuvjIypKNB0n27Ik97AcHp310dAoNuMOnD
 P1yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792524344; x=1793129144;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wmPgVp0vJT8pZqZwkdbDsSNO23joFvpAThJO8aTHg5c=;
 b=gC9wRxa+tp4DKMRlsHWE1lT77WpK0TT6JIKLdV1rMN20ORnRVcwz5SYxGkO8Qoo1bE
 cjnDdhQe6cLdBfSJXuso75OyfspKgcyFn8zLHlavGssE9FKVGU2TaouEymLPQmtqn3Yb
 71WljcwvAMUV7GhZ+U3lZ/X3vRRyRvnpvpO1UQlK+Pk8ZS04XarF4PcEhSVGhJcgKO6n
 AM5/G7lt5+L1yv1scyD0IS0sYoPzvR9SBAs6kVjIQMzs2OYmXW/LwjEZg0QTobdPl9TB
 ngEPR/+hfN0kROj/VSb/gemjkVIU5TCpliVK1RLVALnEQk73wNQe/oPXOa++o3JIeq1t
 /pKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzjkKLO0QmsNaLiQugMT4LuWQVwAEglINGf5cVxKfayayFx01ZbpP95qj0tASYMHM2ZGmtMKKteVgGk@nongnu.org
X-Gm-Message-State: AFq9FYIKP4J0vxRWflAbEWHXZBdOKXm0tK4MAnySVLTtahqbI6gaAUss
 7rE4GBAso09hz6FEm5QO2peh8hjhSfD5mYT4s8dbFycXmWewPJhP1T5nY/JyXsfmaLx+ED+bfJm
 tztn8bqnbEkqEON0zhATGLwoQfbnTdVFL3+SI+plhFybazwFK6KXp6SVz4A==
X-Gm-Gg: AYBFou3gmUqAhREbfDEGfG1trOFEmXYUHpJEv/81IZUM6+nrF6XJ0MG8urfA23wUsc1
 2H24ew64O81F+A9/NjFbuvMwfsgjznc3OUrPxyQa4JQv9oY+PPgxifcwono+wkEpeKx56oTUsvY
 4V21xfVqqF2iDTVIb9mdM3UZBYGbgW2zJ1G8b7VkOaxv4QncGV6wPzK3uDSamhRR6YR6DUT4WIe
 hCEItzlYxfmyGySMJHjshPomOELOM3fNpDm7IwMhb12VefisHICff/0m+6RVRacrZ/zq54PG+F7
 FmCoaQShEBQnEaMfKYtBO7UOyFTCub4RGmTAr7jnZRxbDNQDbEO8GdR6eB7fmAvc3a4EZPkZaOx
 ijX48tgRZYDaonir0BwBf4hnpMEts2Hs1/wcbdk5HeX7rG1zeUBi1W6uUHSPe009t3vzJxg==
X-Received: by 2002:a05:693c:41c2:20b0:366:2893:7429 with SMTP id
 5a478bee46e88-3674e0501e2mr239709eec.24.1792524343976; 
 Tue, 20 Oct 2026 12:25:43 -0700 (PDT)
X-Received: by 2002:a05:693c:41c2:20b0:366:2893:7429 with SMTP id
 5a478bee46e88-3674e0501e2mr239686eec.24.1792524343411; 
 Tue, 20 Oct 2026 12:25:43 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3673e153519sm696572eec.3.2026.10.20.12.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 12:25:42 -0700 (PDT)
Message-ID: <17ba5bcb-ae7b-457a-987a-39c660a1e572@oss.qualcomm.com>
Date: Tue, 20 Oct 2026 12:25:42 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] cpus: Add common CPUClass::exception_name() handler
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20261007094516.75732-1-philmd@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007094516.75732-1-philmd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIwMDA3NyBTYWx0ZWRfX8Ihc0jeBPrtl
 DVwNz1iLNNHp5mbLnbRHpO4k0CpM4b7R9ATtq1vJsYPaDT5osiSsUWMZz0PVRgl0A4jFXzDveTy
 KmkSJaBmi+IH15WLMd3lzMcba2ju0hqmXbOYXQQFjfPJQEUezCk6qUo3jY4MuuaA2NSG1qHaTW0
 jBkArsIkWO30Ex0BnJOoLq4qdYXkh44PF3SnpmF72Y0Wj3aVyhOkyfOfhRUS5fISaMHQ6tQ3fjA
 HcsU9mOrkQiomgTcGVzO6kCkZ7vDDdrlqgKWl9MiN8tX+u8toSG7OuP0bLm0f5OGPzHjjN/NIb5
 eWtHefFEWFEfloIFmWFWPF51PsCg0TSzFqLbGMPC0B2RiP/RFPZCY67bRM5yyXRoaF3c83faPd5
 0CV4OZFw9p151KO/BcaSza8CbMJjmdSht8NdwH4sRf8vX2teMqsceH7NFvEFj2EYwwuDTIjZTRm
 /lxMlExke9kXcxiZlzA==
X-Proofpoint-ORIG-GUID: VHHS0VIvFyx64gC6oiTYS-9C1CXv4en7
X-Proofpoint-GUID: VHHS0VIvFyx64gC6oiTYS-9C1CXv4en7
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIwMDA3NyBTYWx0ZWRfX0QLpvAGb8xz3
 8WzbBaiKhiU+Jw922d6NduBmLjIXAy4v7aeOOoqee0EVws4t9alKAsfdZyhFuWb7oXt8A6fh/OB
 IuEvqbFF3WgYlzuU89g4E0FD/OHjCXw=
X-Authority-Analysis: v=2.4 cv=NppE4MdJ c=1 sm=1 tr=0 ts=6ad7c038 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=hsH1Al6PIRELnilXmF4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-20_03,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610200077
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/7/2026 2:44 AM, Philippe Mathieu-Daudé wrote:
> Add qemu_excp_name() to resolve QEMU internal exception
> values.
> 
> Add a common CPUClass::exception_name() callback so the
> generic exception logger can resolve architecture-specific
> exception values to human-readable names.
> 
> Re-use existing methods (expose prototype or refactor) when
> available otherwise implement new ones (AVR, X86, MicroBlaze,
> S390x, TriCore and Xtensa).
> 
> This series is the base for consolidating exception management
> in accel/tcg/ (more series to be posted on top).
>

Overall, that's a nice series, and would be a great addition.

The only general suggestion, that applies to most of patches, would be
to factorize the following pattern:
```
    if (excp < 0 || excp >= ARRAY_SIZE(excnames) || !excnames[excp]) {
        return "unknown";
    else {
        return excnamed[excp];
    }
```

by defining a macro:
```
#define STR_ARRAY_INDEX(array, index) \
(index < 0 || index >= ARRAY_SIZE(array) ? NULL : array[index])
```

```
const char *excp = STR_ARRAY_INDEX(excnames, excp);
return excp ? excp : "unknown";
```

Regards,
Pierrick

