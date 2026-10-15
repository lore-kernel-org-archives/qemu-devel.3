Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8D77CC6B38
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2026 17:34:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHPLb-0003FD-8B; Thu, 15 Oct 2026 13:34:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPLX-00033H-Px
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:34:28 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xHPLV-0006Zv-Dv
 for qemu-devel@nongnu.org; Thu, 15 Oct 2026 13:34:27 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69FFfYgI4077452
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gn52eERRzSHl93ujOhO8L+Fm4a7KZT0nT3Ef45VgZcE=; b=QQn6nCMRj3o4Q6bC
 dFeM/izBNAVIDoYuxWek9QpOAD8KiRNxpAEcxz13RurXAlFfCtdyeArIfGVB1XxA
 iqy7l1w3JbW9Qq0u2Was7a/xj86A4L9LW7S5Aky4EPDqOFbkUZQnKtq01hwvwFYX
 qNA8QK0cCKhcdR4K5tyHLWWGb1qXQgxnC0ZGK+Ei0xC3Xrc/MUcWV6w5Zl6bG3lU
 yGhPRbwntmprJJ7lbJ6O0hknGhPyXkaiEF7Xe6N0BI2GzjkSzRhXX6M2c+7C0G+s
 oSfHfaCHUwDR1KVmiaeIBK3che9GQbe7kymPQIOVdlTBMqW331yOSU6GEQ6h6TpV
 j4iEWA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4havbc1yv7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 17:34:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3510d0baf63so7065213eec.1
 for <qemu-devel@nongnu.org>; Thu, 15 Oct 2026 10:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792085660; x=1792690460; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gn52eERRzSHl93ujOhO8L+Fm4a7KZT0nT3Ef45VgZcE=;
 b=PO6d4e6fcHoYDMuPV22KfYVbzSza6WcoB1HpvgeOwvCTgLgLh4tKUPV9atti0jEe2t
 j0mL7XxeZ/4FpguGnxFTJUGCVH79qJawTdnvaDOuqrwF6c7kaiDPwI1CMl10c4WKSgx7
 T2+1VUzluVyVrnUM/2P5s1IUjpjGK/pWiptnio63joMHdC6O0wqpW+jqHsWPr4tGH3Jd
 TeRyUbL1ZgfYzMzNTlGNqF0rKas9MsypmyFMUqwts0gN9lXqoIdMa2i73P0urIJDU2iA
 rBOXaTvQQg5xed+ZotwGK+QOloJZnbe7rHesrQv3i2uUXUr50pKkRsN80MnRBtpvsnHc
 wv9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792085660; x=1792690460;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gn52eERRzSHl93ujOhO8L+Fm4a7KZT0nT3Ef45VgZcE=;
 b=KjF6x2gqKSKCIHb5y8UN4z5+fiE06UibVbtUDB1s0cN+cyAGeJTNOYes3hCXOf57rP
 V6JpdEElc6jLKPC4GrQ/vtxog44s0KZUCBvRQdv1BplNsJbMVTR8oJR67hzdVCWnzY4n
 gQ3gx1I8PwDV2PGio5zjpSLzkBbiEmkmSfxsy2EcS1YCyOehipNb1ut2OTR2l9IXxeQJ
 XwAf1XKYuC2jc9q68XpUN3hzxwj6FT6vhWNdYckYAP8lQG4FJXLRr1dh//Wv7e/asdQA
 KOGQtucQ1iI+kfB8bFAF/aT1Os4bATLFgyfuHStuLERsFbZNoPKYyXYyvkfOcetT85vZ
 4nZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/Baay4GAVNnf38eDUOqSD9c3dog1GQXl7aO8n/majDgbQbdZu9Hrz3qv/lhAAfaJI/1NU2ruHhwXn@nongnu.org
X-Gm-Message-State: AFq9FYLIAjierNmQC/taYZ4FlaQ1BknRjFrxTiY9cFVD8WG1FETdgtmr
 DfWz6dF1vu0RQlO5XvJUAfCQy5BzqsSmhD6qBOSjXAjdnyOoVeH0y2VvBs82kPAxSQWdzrTsuph
 xOFovhoSaD4rVxsTxoKE75Sf8WYabxWMFtMiSis1i0JN/l3ZgonqU1kKH8A==
X-Gm-Gg: AYBFou3NGm7rNmzYHuvTiKOO0qhwY4wrejYzb48UWSREJ5R6TVmQjeTR2G6TZqvxXOL
 qc6gBTuE3/6DACBCIKnGUvKOCGemUjIZe7lIkIlDAZuhLAAx0HtiiV8+CTH1C4C7Lk4PdSQcll3
 V9eKlUxQyIJltlGWkMfmeWSA3+tAMcPv5l6mhNm88k2dG8zTflkwWRKTMVI43abUsvFvwdA5URA
 yt6i/xBA0UxB1IxEu9aLQx5XHJN3HntIUhlcIvlJ2KqBZutvOXJqAjcnhePYgBGPGUoVq+LIMuk
 I9dTVpgyOl98Aoaqf8mcieF4fIyV+dOhurCZ2RSX0wIGVPjD4CesF8JOvZSfixsmL7PsmtvkgtA
 FFkcw0v0bBzpu2EkzdMP1nk5uIRofbTYAD0fy/1m9Vc1or2+gvcBNILKhgxY56sEGSuCVtw==
X-Received: by 2002:a05:7301:78c4:b0:35d:b452:902a with SMTP id
 5a478bee46e88-35db452916emr8830179eec.34.1792085659901; 
 Thu, 15 Oct 2026 10:34:19 -0700 (PDT)
X-Received: by 2002:a05:7301:78c4:b0:35d:b452:902a with SMTP id
 5a478bee46e88-35db452916emr8830087eec.34.1792085658448; 
 Thu, 15 Oct 2026 10:34:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36057077e59sm378997eec.8.2026.10.15.10.34.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Oct 2026 10:34:15 -0700 (PDT)
Message-ID: <e965c91e-cf92-4647-bc18-d10ad39e2025@oss.qualcomm.com>
Date: Thu, 15 Oct 2026 10:34:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/21] system: introduce a live data recorder facility
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fabiano Rosas <farosas@suse.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20261015112044.1999748-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261015112044.1999748-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=QbvzLcbv c=1 sm=1 tr=0 ts=6ad10e9c cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=YGKwtQbzyU6DUE_ilQIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE1MDA2OSBTYWx0ZWRfX5SML0wkRCNm4
 gq28YbeAiO1BLEDVUfaoYPV6nUgFwgHCEE6rIvGQSZUlCz+pOmWE4dCiUuXD4681RkqLwDVYrwq
 cf/SQqWzmwxdfWunqUOJOUx4YxHohdk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE1MDA2OSBTYWx0ZWRfX+CYdT+uv8+vC
 Ow5lYZ8Y/pcUFNIS6WU5YcgKH20DTQA7hj/R34XvGRVOWxXGfXrOChSLk+pkFJwQ5aK/mk3X1Q5
 JlSVnW91l5nOxLjCGEZxO1JwmURydncCCpsgpUOKG+8y+NGg0MMGyTAiHJJwc63aYYaH/BuSxaL
 F+RlfSWKo/wXfOsZp6CApVNG9G9dDHqgi1ZIUGxdFqDcgINa+PTpp787JaOBZ7YPea/iLUZgBvK
 tgduddvsINRHzvqajvWeDQ8nx2MMhbeuiwXmh9vb3VFafWDr708xB9LrBr3bwVKrF/rjYCg43tf
 4O7hzRZ2TaYiMhj4/p/8nHIfbZhKEccy7LMaGfVXarkoT7qUFgkqnPbwFruDyZYQNi6bj4vDXbA
 wg79v7T2fo1V/pkZDJ6c4nLvL9Avy3t/pFbGZ2fUOtf94WeQvhakHVP1EiD6E7r5tWHyNdXAsnr
 eocFBpPBaIW42jCrBiQ==
X-Proofpoint-ORIG-GUID: Rj7gstDtTdG4_sUd8-nPfIv0vS36rvTO
X-Proofpoint-GUID: Rj7gstDtTdG4_sUd8-nPfIv0vS36rvTO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-14_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610150069
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

Hi Daniel,

On 10/15/2026 4:20 AM, Daniel P. Berrangé wrote:
> This series introduces a new facility called 'tldr' which is a
> live data recorder. This is intended to aid support of production
> QEMU deployments, by providing a data collection facility that
> can be left "always on", such that in the event of a QEMU crash
> or guest OS crash, certain important information will be recorded.
> 
> The data recorder has to be enabled by adding a "tldr-config"
> object instance with -object / object_add.
> 
> With this series, the data recorder collects
> 
>  * error_report/warn_report/error_printf messages
>  * QMP events
>  * QMP errors
>  * QMP commands, which are not query-XXX/qom-list,
>    or any command associated with a QMP error.
>  * qemu_log output
> 
> The last item is intended primarily to be used in combination
> with tracing and its 'log' backend, to have continuous
> recording of certain interesting probes.
> 
> Each type of data is collected in a distinct circular
> buffer, such that high volumes of one type of data, does
> not result in overwriting other types of low volume data.
> 
> The data recorder is set to trigger on SIGBUS, SIGSEGV,
> SIGILL, SIGFPE and SIGABRT, or manually via QMP 'tldr-dump'.
> 
> There is a open question in one of the patches about SIGBUS
> handling, since that is already used for MCE capture and I'm
> unclear if I'm breaking something about KVM MCE reporting.
> 
> This series proposes using sigaltstack() to register an
> alternative signal handling stack. This would mainly be
> useful if we have a crash from a stack overflow, but the
> cost is that we have 8k extra per thread, and I'm not
> entirely convinced that's a beneficial tradeoff. Might
> be better to just accept stack overflows as a risk.
> 
> This series only captures text based info, but as a followup
> I would like to extend this to capture statistics data from
> relevant subsystems. For example, the BlockBackend has its
> own "always on" stats accounting code, which can be queried
> with QMP. Ideally I would like to figure out a way to dump
> all the BlockBackend stats in the data recorder output.
> Likewise perhaps capture NIC stats and/or KVM stats in an
> "always on" manner for some interesting baseline dataset.
> The challenge with that is making it safe to access the
> stats data without taking any mutex locks, since this must
> run from a signal handler.
> 
> A typical recommended usage would be:
> 
>  $QEMU  -object tldr-config,id=tldr
>         -d tldr
>         -trace events=/var/lib/libvirt/qemu/trace.txt
> 
> This leaves dumps to go to QEMU's stderr on crash, but
> to send them to a file
> 
>    -object tldr-config,id=tldr,crash-target=/some/path
> 
> The '-d tldr' flag redirects qemu_log() to the TLDR buffer
> instead of stdout, and the '-trace events' arg defines
> the "always on" tracepoints we want to capture.
>

if I understand correctly, the goal of this new object is to provide a
per-topic rotating log in memory that will be flushed on disk only when
we have a specific event (exit, or any signal). That's sounds like a
good idea!

Why not refactor exisiting trace/log and provide the same feature
directly there? This would be transparent, and user could decide to
either dump the full file (same than before) or benefit from rotating
memory buffered, with any custom size.

$QEMU -d category,size=4M -trace events=out,max-size=16M

Regards,
Pierrick

