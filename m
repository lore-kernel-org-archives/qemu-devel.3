Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3082E606A31E
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=QYFewxHV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=J9e56G/R
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJzHL-0006Rj-SD; Thu, 22 Oct 2026 16:20:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzGz-0006Pb-PC
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:20:26 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJzGy-0006uT-1Z
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 16:20:25 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtvUF360352
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:20:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I36YSwEcoEgcIpPhbp47frrUlI/sB2C1ZJu8YwPbTHU=; b=QYFewxHV4MruCZLo
 olpUp/3ncg6Z1Wnil/8YZfsPv803wqd2HC34+5K9FNhd/M0/yYEsALNZJPAKqX2p
 5dys9l8FrKVCWobSfC3UH+0qwlPLuYon2OW248eb6/WWojQ1py6+E9JB56Fezhn+
 Lt/ZZNoRfOWWtDD17pZpYx1EJOF35N8sysRUZJQsmCIqw1AFedTwOzbcNKs/uVpr
 T7QqMlhqos7F1SEaQKg5tfhbuQct9+h5AifEV4nrCcM7Gd9TV9spL7ZrfDIhReWh
 pbVgrKwLtuPLrHF1xIXT2xQv7u2DAy8aS4OgSV5hfLBsQoYjfbpKi1Yc9ES9gm7f
 A/qbMw==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfnyw0xfx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 20:20:22 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so464061eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 13:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792700421; x=1793305221; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I36YSwEcoEgcIpPhbp47frrUlI/sB2C1ZJu8YwPbTHU=;
 b=J9e56G/Rsf5OC/mr5v8/tCDvf6WlpEpevUOnMhowKpLCrqRDl0dVTBbxSXcXUPxKMg
 ENWzcp/tRiDg/dec3r+6dt9YyczdpT2Bbda/t/iaNXmKRQ1YQo8nzHOTFB/PSnQcRyGl
 R+aV4Ov2Q/849aw1sLwFoXmOBd8+sOd0hcpCdem8XgWKv0Rr/Rfi1iRFxFz1rGMHwP98
 Ho/ePx92b5miBM1JOG6AuD7rm0DYzDSKdScuMO5rDgvs7vsE2nCe3hKSUDelSp7KmfRo
 6QO8O2IKeefrM/omfbCruV50oK9q6QvQGk8xh9nJ/x213GLvw6p5zkNDJf7Gq6dFw0gj
 JE1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792700421; x=1793305221;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I36YSwEcoEgcIpPhbp47frrUlI/sB2C1ZJu8YwPbTHU=;
 b=L1IJ4dA48vfPDWbOmNQyAJShn6Si0ybR/gGVDoFX7WnNMZMZMqFAbDw8ewJdCaI5Eu
 VwlrW3Q16U9CONwfs6Mv7i5nbSPT03M00QcJg1JeM6X24Vp64n75tTSkRCTc98Be5qZD
 ZxBlORFIZpIPiRBEb4HPgk3vFd7N0gaXD4l7XTgfVWiHJyNgoAtzx54eAXs3mLOf0Mlt
 +sVd+MMGyKoW831dRNVL9ITPrrF3HlJZIvuSGvlkqLMhlQj1zc0FQwpePOyif0589GJO
 V7/8XBl1dTSRXMaG3V5bgaaZGIzLzZrbePBSexU91Jfx9CyiL1JSIeLbNxnGdXGqBb1l
 h5Wg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzdkRbMiy17E9ff49WbG7P8wsRu6MYQMjyCcwYnQRPrAG/m4f9oQUNJcnGep8MwbcV0+HIUlsS/Eoel@nongnu.org
X-Gm-Message-State: AFq9FYJzDzhBVa62oJ0HIQHboZ/aRt01PNAz64aI0SUUOp2JCLO5rvcU
 p3W+WUEPOkIc+DOFPC1qBT2Ufzb3a96u3RbmV1ul5QYN6f6YYU35EQdaVxoj2/CQbIwqFd+fZUG
 HVkI9UNQmsZB2QVQ02xFVRRXfhX4b3k8eEvWWdzpcJRVo6J6YwkBrVfN6qQ==
X-Gm-Gg: AYBFou0YMIrQdBVZlW0IaRjyJWCawZ9XOaPRUrG8nB+R+iTTIftKbO8LCwmKnOxkiH/
 V8FPWjLEltS+/uXPHBlOptqnIvOF3N6BFm3w7elMyQa6UeslnF9S7A3zGD/KgsR+U+jmzjH29cB
 cS8ny1RR+3865TfJwyHuz/QlmVbyHEE8YvHW/PGRtvZ5bmNd4PzSapAJL9MDydqiVmiEH8VipPP
 vJDpzqrmEi+5/Lqbm5k0+wGToYWpxWxXosiGtmbBN8LAlCLCQ7Cmh8H2cWFIzp6aB1qEcP48k2i
 xlnr9vXBBcotVGdkdsSBu3rCT5CWT4QLWmm8rADQqg5hJcGUM2djG2ATpozG6fHpFaXnacg94vC
 M9RwaRP43XOoO/hfZz/mSKrZErmN7dUFSTTUQJRm8kULmoQzQ9TVMgk7+zelhlWxgsKgSOw==
X-Received: by 2002:a05:7300:c001:20b0:328:7033:9b8c with SMTP id
 5a478bee46e88-369d97a994cmr253953eec.6.1792700421165; 
 Thu, 22 Oct 2026 13:20:21 -0700 (PDT)
X-Received: by 2002:a05:7300:c001:20b0:328:7033:9b8c with SMTP id
 5a478bee46e88-369d97a994cmr253931eec.6.1792700420568; 
 Thu, 22 Oct 2026 13:20:20 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-369d9d892b1sm249954eec.10.2026.10.22.13.20.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 13:20:19 -0700 (PDT)
Message-ID: <f796e6d0-79fa-4d6f-ab77-bc739687e3a1@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:20:18 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: tests/tcg: how should we skip a gdb test if the host's gdb isn't
 new enough?
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Song Gao <17746591750@163.com>, Bibo Mao <maobibo@loongson.cn>,
 xianglai li <lixianglai@loongson.cn>
References: <CAFEAcA846O2jbpDvy+zUnxrpfxKLQpjhHq14zBOGQMC6caXOJw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFEAcA846O2jbpDvy+zUnxrpfxKLQpjhHq14zBOGQMC6caXOJw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: gtU5NsyGwjkbjJVbLj_pCX8-geTofo8v
X-Proofpoint-ORIG-GUID: gtU5NsyGwjkbjJVbLj_pCX8-geTofo8v
X-Authority-Analysis: v=2.4 cv=dphOmFg4 c=1 sm=1 tr=0 ts=6ada7006 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=V-8JyFtotrw2DmqW:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=uU7zoOtyWLvA5QY2yuIA:9 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA4MSBTYWx0ZWRfX1bADcYAxinCS
 KdJMseEA1l6wWrd5Mv8AhR4+DO03AmMpZupq+Gg+DME7Ra6AO6yoywnFzwgA6C+VVYrBw4+G6mw
 UXlgYfpE1KC9D8W5TWnU6qvjgY8RQDg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA4MSBTYWx0ZWRfXyuc3yi0QGwtP
 divXRstLHEwvN8VpRlK5tCDEWpSimmHk5Ze0TBu2DphDY2k62Zg7JWSLQPXZRSdlZiAjFXNJP+I
 N3mh9VuhgQymVp29CP/BcJ0sQP87c9bSAMVb9shuqJzbFgwLxSXO2FYbVGnXQsoYCxgFmjVlC3p
 K/DmZfOIKvd4GkcjCNRPbrI6NHvy7KbnJ7xOOZCWLx5csguQuNfZQ4n4ZRWDwCoyBQHSAdkQonx
 D72yAiIWWUFhGIVEcbNbnlyQTBvQ36Q9siG92xDC/ioTIFxQtqjTJ5EGr0N4gawQ9ta5u1vkj5m
 Z3kYCuVngUY6jvLv8MUUSaKi6E3nlH8N4bYNbboJfhO2CxsBuRPgTDfAVbAZw0thkFJQfLf3h3u
 ssZXk4UeHKnFIAgIb77bWlcC30cZTHYudkYTx/bWiOjvEZFGqojeVnWvVInbTuD7WqrJfZWuDRD
 JAeM5SgkxV7szaTkJcQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 clxscore=1015 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220081
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 8:51 AM, Peter Maydell wrote:
> I noticed that the gdbstub/memory.py test hangs for me when it tries
> to test the loongarch64 architecture. Running it as a standalone
> test (which is what "make check" does) hangs too (transcript at
> end of mail).
> 
> I'm guessing that the fundamental cause of this is that my host
> gdb doesn't like talking to the gdbstub, and reports in the log:
> "warning: Architecture rejected target-supplied description".
> (The hang seems to be because we continually re-execute a
> store insn that provokes a debug exception -- presumably the
> gdb is not doing what it should at its end and reporting
> and then deleting the watchpoint before continuing, so we just
> keep reporting the watchpoint hit to gdb endlessly.)
> 
> The gdb is the gdb-multiarch Ubuntu one; --version reports
> "GNU gdb (Ubuntu 15.1-1ubuntu1~24.04.1) 15.1"
> 
> How in the gdbstub test framework should we detect "this gdb
> isn't good enough for this architecture/test" and skip tests?
>
Thanks for the report Peter.

There is no "minimum gdb version" set globally, but it can be set per
test defining a gdb feature.

I wrote a series (that fix current issue) here:
https://lore.kernel.org/qemu-devel/20261022201733.1941651-1-pierrick.bouvier@oss.qualcomm.com/T/#

Regards,
Pierrick

