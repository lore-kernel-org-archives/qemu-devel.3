Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30E0606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 14:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=oHTfYHnV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=REsDYsgi
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLiPA-0004Nk-H5; Tue, 27 Oct 2026 10:44:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLiP8-0004N4-H4
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:43:58 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLiP6-0006om-SC
 for qemu-devel@nongnu.org; Tue, 27 Oct 2026 10:43:58 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69RDo7Q81486569
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:43:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 huHvnpaNPiJUf5Rb7l8/xyuFKZ3wNpG00fMLgi30jlc=; b=oHTfYHnVYEb/Zocy
 tHMi43t9LtEJpvhV2D4JEmhMT7W/Ni+SWTWnjRt8KEKOiDP/dYbTr9nEeSLwyMBC
 B4KvWX4VZuBd4BKZU2qal3rzuRyCdWD5pylZ7LKBepYhVDfrOsoTMJHoxa/WT7lf
 roPzmhepGvQwQaW1SG4V3zd3zl9xLZ0kJMe/BMlqSxNauoK/2mbcZPXyjAAewvGp
 7JNf2iCr0aeE0Ig4W17rCdCOFVM+9tSLSUdo3duV+DH0PY9N2yFmViEd8keIHuLH
 WAvpWeRkI8fd2EkyGV/xtlrwlezD+2UgN/jbCwo1puQkyjdUKBH413cssCu7cFwI
 kjxzsw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hjp2ta30j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 14:43:54 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-936aa34873bso796459785a.3
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 07:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793112234; x=1793717034; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=huHvnpaNPiJUf5Rb7l8/xyuFKZ3wNpG00fMLgi30jlc=;
 b=REsDYsgiaUot9gdowIbqCcx7oVM3onSd0dsKDXBV5gE3L7rsGme95IVhlhFGIcrluU
 w7SqZ37KDAUwmoA2Q2TLmVCijLStxDpYyl4Q3VYx3YoYjC5McrDuaYELm3s0iWCZgeAV
 ekFGIDahQzvMz45zb0YDI8kBZGPv7lunOx36oE5tEqcZRz/aUXAUkIgU4TapEbo5cxKw
 iYEV6CZULO8SZIjiiPFJThNroiZoOugDLBb5uYc7uhwpn4hShhZnUdGgwIdtqV5CKcmH
 kA776zushnX2D19VuRfePrdI/dtJ/ospP1sX7D45WFweci3hMIsq02xDQ0LjNR/ztwD6
 MC6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793112234; x=1793717034;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=huHvnpaNPiJUf5Rb7l8/xyuFKZ3wNpG00fMLgi30jlc=;
 b=ZZVLaTve3o/9+71J5CLZLRhmvcAnXNWM82xBnP9jCVvLnWjrD9mkqWCYDfKB+30mvM
 gFTb6RFxXIuudpD3ospNnq5lbmyFJBc3k/cLupJp1fjH28eOqu78ghTO4xuu8qGSDB7c
 2WmsTYjynEsRxjlO20NukfKGRO32J1moR+V7TR8T68oPp70FQKMSDet/r0+Z6Fl1D0AD
 EgHfSxAQ8pGCEJY62vgxw0bBlx6wxszgsZ2Bjr6k0QkK21/VavcJz5pi5FnpwEbgoQWK
 Ub+yyyAIvEmN/IHOukP4o5PjuB/0Izpk8fw55Rc3olZZSuEbZd1JTJRmndICJoo+XfpH
 b7XA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy3DFtt5YDbIWMcJ17ktFLd2zSGBybNVSGImTTjArE7a2ipcoBOHCELSIFIsR/7UgUbRHzGk73vfovy@nongnu.org
X-Gm-Message-State: AFq9FYLYrGNT708CuthoeY12l6osQbNCVjHDHYsmrIt5HEojPZQfUyIw
 lJ74ZVM8APJ6CUDPlwwzQEAtWw8w5KeB7y3OoDcDS1y5PsWFQwJisWJHXUZI1QjKKXDskm51jSU
 IfKRWd489Pj4rv7QFKWarv4oOVz3amgn3e+PbhcZoecAwXCkUVBZxPzMkPw==
X-Gm-Gg: AYBFou0KdgIrcCiJyBnBpanljEKLL0QYQjZl9SnVn/itH1wmFULniUNLpM82okXOoWC
 P87LgXHdaYcWheeVxP/yXEuhL9IPKEXQN5ZCQ/e5CaxJcOlbHGvRtLXqPkSteBD+Jc8NZfpFe03
 yjYhN9S8KRK7GzdpwIIUuwSPfHTpWExRmt38YWCvwFCq4Fd6oOU9iDV6T4ZLuybx0b15DjDfjQp
 rmoK5K2+kWtL6zFYbojYVVpF97w0jn6hxfdalJP5BMLnh6YVi3g3cFMJUXhv4PKEbVcAGb4Ch6t
 QZvZDFGRXMcTPs3E11SmLyuXZ1EyuKYiXNSMOoyeEQTmfWC8yGnWRwvK7gIidkRb0LB9wpKnpCQ
 nzlTibzoCnw00o9WBzlg/pupgffkWuLmcKkrArtk6u/CYzn+TxA==
X-Received: by 2002:a05:620a:1712:b0:93f:5892:e5fd with SMTP id
 af79cd13be357-940ef7d66c8mr1505590485a.1.1793112233731; 
 Tue, 27 Oct 2026 07:43:53 -0700 (PDT)
X-Received: by 2002:a05:620a:1712:b0:93f:5892:e5fd with SMTP id
 af79cd13be357-940ef7d66c8mr1505585185a.1.1793112233205; 
 Tue, 27 Oct 2026 07:43:53 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ebc3bdbsm19001949f8f.19.2026.10.27.07.43.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Oct 2026 07:43:52 -0700 (PDT)
Message-ID: <27104daa-1b42-47d0-b84a-f1458baa620d@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 15:43:51 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] scripts/clean_functional_cache: tolerate missing .stamp
 files
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Thomas Huth <th.huth+qemu@posteo.eu>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, John Snow <jsnow@redhat.com>
References: <20261027140305.4027440-1-brian.cain@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027140305.4027440-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=AJjzCM5L c=1 sm=1 tr=0 ts=6ae0b8aa cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=KS5Bgl_NgPwB0-sxteAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: QPcTqNQbIk52hhg6Sl1aBcjH0EQDJEfv
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfXwIWTNZ1ZHZYs
 b8en9n4SuCcqoN/nsFZHl6zFW6u7CCdTo1fAY8DrdEHBH5Pe8HY0Y+CgQChA5/55F8PBlzB3lBu
 hNhF0WkWGv5bLi8ZM6AiWjxaPZQh/as=
X-Proofpoint-ORIG-GUID: QPcTqNQbIk52hhg6Sl1aBcjH0EQDJEfv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDA1OCBTYWx0ZWRfX4CAMoeE6y7FP
 AFxFAWGokhWL9SB/9GcncYQzanCU5KgfbZlpJ9U3at2s1mUWdp+f7R0gIXvSGR5SqLDEPvW3baj
 UPNpRuB6WGqdqfjN3fhTAAyBy8+FZ7wYC1iMVeiiBvGPM9G5ZTGVyy6UPfPwgo1G35U71t2LMxX
 K2aPxu3xyWcwRfCaGdfnovmAoE3qzgti1sFUv4xY3naS15QcCxViJ/T97+sx98ypzKwITqNwkwZ
 H6kLbXF6O4YRysJ7QNZX/sloSbmAPIdwSMbW8U1pdhdgSGhDY+q3nPgJJvkPBUqVJd2ChfzhaNJ
 7Uwo1EOBw/RdrQEw9x8rhfo60FBFtOTD9HBGizGRWAEgWJSOA4JMFISo5CRLAXOSpVQieikwcmG
 FMRBpsq2VHLzdBuMn+ElxPGagbJq8qpyRs/5p8PlUr9tZuThqctV3UCC/7BbapoWkWv4fWD05iO
 lgYGuPviYap8AQObZ3g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 priorityscore=1501 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610270058
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, KHOP_DYNAMIC=0.001,
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

On 27/10/26 15:03, Brian Cain wrote:
> Assets cached before the stamp files were introduced have no
> corresponding .stamp file.  The script already copes with that when
> reading the timestamp, by assuming the QEMU v10.1 release date, which
> makes such assets eligible for removal.
> 
> However, since commit c1bb594fe41, removing the asset also
> unconditionally unlinks its .stamp file.  For these old entries that
> file does not exist, so unlink() raises FileNotFoundError and the
> script aborts after deleting the first such asset, leaving the rest of
> the cache uncleaned and returning an error.
> 
> Pass missing_ok=True so that a missing .stamp file is not an error.
> 
> Fixes: c1bb594fe415 ("scripts/clean_functional_cache: Remove also .stamp files")
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>   scripts/clean_functional_cache.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

