Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25FBB606A321
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 11:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EusmiEN0;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=GO6dOymM
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJrQ6-0004Fh-2b; Thu, 22 Oct 2026 07:57:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJrQ4-0004FO-7h
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:57:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xJrQ2-00008G-A3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 07:57:16 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69M9xwPR3478867
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:57:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 00Yi10LCEbyy6sORUXMR3FNJR30KRLpCsd4btlPovf8=; b=EusmiEN0DQH8udZg
 zDnffXbx2W3195uhTw2sFXsDcwuAx7rjKY0lxbmjJnTjGIs4Mfpu5RsZbWH8BeX/
 gpAOWktKdVbTiKBKTaYa8M2AGREPpCg1XID5uMlWkSABy1h6PKeDnKRCN5ejQ1G2
 OyXGutjIjBOPuzcwAROl0qoXBIFBO0kFuzftSwqCOxGzhzwbh8v2CctkPPJOgyjo
 3FBNhvW30UHYeJkB2q7t67BCJE93cj7guX7Sf1Es8dfXxbuuLTCRomzwbDcNpxQJ
 Twe+2tW9s6bJX1vhjAHK8ZutqXZDa/RgjUsQ9Y3lUD/fW13AjGNQqKlPB7CCw+dE
 c/C95Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93a30du-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:57:11 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93cb7f9bb86so389472585a.2
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 04:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792670231; x=1793275031; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=00Yi10LCEbyy6sORUXMR3FNJR30KRLpCsd4btlPovf8=;
 b=GO6dOymMZlIGk8GRiayzGpHtj5CoPTR9ZNyzUQJn3+enNymcMI6962AiGuJ+eA3cNM
 QGk6aVc0IWpmSjWSgdLIMopwLGJmXuQzy2keYKceBrA1eamhTqKoqq2JPF8YTl/mRMRh
 5UdqusgPuxYwadmumo9HATc0tJEVoEcPDpNSSLn7vcCQ1rshzbUgW5Nls2PdiqBJWOxY
 urFNYFz+dLsq+yY8j29J8EoAjFtV59kBL+dlZcRVg6SgAcQeipZEdzJfj6n+8b7VirbD
 kxxZDLIprfmtqbu97iwB34kQQkjp+tU2gXXbSMAgFdeaOXjTGRQBSdkIFN6iwbshnk6z
 58pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792670231; x=1793275031;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=00Yi10LCEbyy6sORUXMR3FNJR30KRLpCsd4btlPovf8=;
 b=K35ugALLyfrEDUqblCAqygJ0e3lz/EtPU33e+tTw3Zbi2ieCM9dh2EuU7qUL+RaocY
 i0pxLXlbpcVekXy/AQ9WfYuroUcjg/YWAZZZHBpzu3LhhU+bchW8Wo9IcZZtljFB7dOu
 XSUZVe0J7MMggbuVfoz6pGeBbm4l/v7kTt2qCsbztwWSZJZjLea+LrnPhsz8AALGyHp1
 6DifpcZNQfXOWFV8QUOQOCzWPtdV7qsUAxYGtbyYZc4mVPcCjnAflyKidG4cyZa2/N1u
 XMEUS4ZIZGXMETJ2K0NPh0OpDmIi/gf9VvDK1bGb7KP0qttAsuRUazaJrXwDvbA8mgld
 QkLQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz7M1LfcJmfFm3/0UZmuFl7ArhluB+N5KJ1JHXIwiLo2jSY5suDFl0CR7Ey+tvJqV2aBWOy9g+mzkNP@nongnu.org
X-Gm-Message-State: AFq9FYKDVeTNimdK+5lwcKADL/ACV/v1BNvSEik7kcui0agtXzCC3Pvp
 qhelRnaepDAyEvfC90Tp72EdNNhZ9m+eoLFq4zsSOGVzl+b7odvzPtY7jAEiRUuBS8dE34Nd8I4
 I4XqisS0OvzWsilJJ5pBEl9jd7VwJfXAuAuQs11XzGhqCDmeOV9PhJKzTqg==
X-Gm-Gg: AYBFou3rhujQM9/XeRhx8DTuUmM7zvzmGi7Wj7HtkrU1A5P4NSB60rfpX9ZlowUvDCy
 svl6tMmRfdcZwr5/bL3xW84bH99YJqRLel/OPZ/kaETe3QtEPU/mAEhBfG8M0eQE8NghGoH+n1R
 zN8TUSHTHass2/qYq1sj0HH/hSYi1fCBuWG1+xQYuNPS9TWUQcq6ArMQ7F/cIUcjxq1PiWHCG9l
 kj3J0dZWKnfJGvCe52/9ysT1GKU0/JsVenJIviFgwvosSR8yahuSjmfXemHKtfU191LghsRkYn8
 kJ5yENoAXDsn1XyAJDicZpRu7zI10WkLSTjuGArLJ6ZofQbRqIu7Jf++oRwfdPd/q07xCzo4PmG
 8PNWpZQp3A9K7IwP5O3m+LjzZ5h/y+taK1w==
X-Received: by 2002:a05:620a:2955:b0:93e:920c:bfcd with SMTP id
 af79cd13be357-93f57ff1f4bmr914758285a.57.1792670230774; 
 Thu, 22 Oct 2026 04:57:10 -0700 (PDT)
X-Received: by 2002:a05:620a:2955:b0:93e:920c:bfcd with SMTP id
 af79cd13be357-93f57ff1f4bmr914755485a.57.1792670230259; 
 Thu, 22 Oct 2026 04:57:10 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828caesm11290660f8f.29.2026.10.22.04.57.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 04:57:09 -0700 (PDT)
Message-ID: <e3fc4bfa-4510-4d3d-9a24-77c17864e660@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 13:57:08 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/8] target/sparc: Add support for SPARC crypto
 instructions
Content-Language: en-US
To: Stian Halseth <stian@itx.no>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Helge Deller <deller@gmx.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Biggers <ebiggers@kernel.org>
References: <20261022070059.3861291-1-stian@itx.no>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261022070059.3861291-1-stian@itx.no>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfX/dQcKux941q4
 4YAoUHQ5RTH/JtZ+P+9+HMh3sNKYfSR6MjLIsB5XjYcucgvL4FJ2q1mcyNlMRK3I+VBXxFJcdDl
 vliAVyiOAIV2ZCZkQJ3CrzE3MGe3nGVtT01xoSVX5vp474r7Cow5qdCMzInNENyozJ/8I2eXLWM
 Jes3B5Un4Sp5G5ImuMwCDy+k1UK62WyH/fvLYygZVoqJg7yLDsqigfEJfoay2obZLaZgOVRhjDg
 GZnuy9cXbf4/IVnhlxTHGUPdLQFqmNMqauYkt/addBBCajiTYWQEHcaxB4hbPcatYQzcuB5Czez
 eZ3z1CH7d4BeFSsE/7E139o4SZrrlraEVCZn1k7UR0jzy6XPkKjELxLWqTVNNPhQtvv8t9pNJM0
 xba0NzByeOdaWKkvFp5T8JMw4LnCB43uRM6rbCb6qxfUDY+McetUQWnxBK9yj9rspB/L6h4+Op8
 B+HwMssMPKaiHyXGjfg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA0NyBTYWx0ZWRfX23NQYoUZdOYa
 fv/IdSGdDq7PwIZ/9TtQIfgU8YN3znpdxYKGKRk1MlNnSIwLQUfWJCmGp36fvjszp1B1bJMSthB
 MgyRF7Ezkp5NUosDFlwbsLmH7mR9GR0=
X-Proofpoint-GUID: v0BkUrw6gGRl88PFzfD302uxliCFd_eR
X-Authority-Analysis: v=2.4 cv=NaFzRGD4 c=1 sm=1 tr=0 ts=6ad9fa17 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=VwQbUJbxAAAA:8 a=z594M-Ttv3Op33mbCYcA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-ORIG-GUID: v0BkUrw6gGRl88PFzfD302uxliCFd_eR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 phishscore=0 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220047
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

On 22/10/26 09:00, Stian Halseth wrote:
> This series implements SPARC crypto instructions for QEMU. Most other
> arches already support crypto instructions, but SPARC is lagging behind.


> Changes in v2:
> - 1/7: use suggested commit message (Philippe); R-b Philippe
> - 2/7: start with an empty CFR. Bits set in each instruction patch
> - 3/7: byte-order comment, rk half zeroed explicitly; T-b Philippe
> - 4/7: sets CFR.aes; "3-operand"/"4-operand" wording.
> - 5/7: sets CFR.crc32c; "3-operand" wording; explicit 64-bit return;
>         R-b + T-b Philippe
> - 6/7: sets the SHA bits; comment on the narrowing; R-b + T-b Philippe
> - 7/7: -cpu TI-UltraSparc-II,+crypto mentioned; R-b Philippe
> - Tests: Follow-up, as agreed (Philippe)
> 
> v1: https://lore.kernel.org/qemu-devel/20261020145530.3385376-1-stian@itx.no/
> 
> Stian Halseth (8):
>    target/sparc: Add crypto feature
>    target/sparc: Return CFR when crypto feature is enabled
>    target/sparc: Add the eight AES round instructions
>    target/sparc: Add the AES key expansion instructions
>    target/sparc: Add the CRC32C instruction
>    target/sparc: Add the SHA instructions

Mark, Artyom, if you Ack I can queue the first reviewed 6 patches
via my mist-target tree. I'll let the rest which is unreviewed go
via your or Helge's tree.

>    target/sparc: Allow block-init stores when the CPU has the crypto
>      feature
>    linux-user/sparc: Report HWCAP_SPARC_CRYPTO for crypto CPU feature

