Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2ABFC88E72
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 21:24:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6EAK-0007Oe-L0; Mon, 14 Sep 2026 17:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6EAG-0007Kb-LI
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:24:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x6EAF-0004MS-50
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 17:24:36 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EJYTCt1903427
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:24:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v5pdoJwMTGNtoLzBt4HJtZy/CksnGVdvraRwPt0aZs0=; b=LtFLO+SIMSY15CFJ
 qZQZ3VpVjztzGxtAhlEYYWlMTtJ9bf+vAMGchAND4FjBJkYPaeN1nue6VIRPfIGb
 cEFGvW4xTKB/vBfqmibqAAyx8mn+OHS1kuTZJQkJoenC4isXGVk2cz1qwloITQ6/
 GEF2QmVTONyw2OYW4WOaxKHa2GNRxpFdNxtG2lRwJ5tXI38LXhbY4auWUp1gT1X8
 OKpmFTGq2r05BfHw+MUawbpFUiZ5OATuCxD3xS7GAi+qhLLasWynFz7wHOgdCLLV
 4u7Gpso6KG30Gn+ptDCiCr524FpnDvaeq1qEWKx5PxqETXNlDu0g7tFOR1eKaCg0
 PL/IQw==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpdb5u3q4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 21:24:33 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-cc21bc2923fso3589420a12.2
 for <qemu-devel@nongnu.org>; Mon, 14 Sep 2026 14:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789421073; x=1790025873; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=v5pdoJwMTGNtoLzBt4HJtZy/CksnGVdvraRwPt0aZs0=;
 b=N6s8pAz/B2F3TO5WpjAAdR2wM2aFwX72eoAmuDg9pfOMoOlEkzO3KKld24ojeG+aRL
 +ch9jFi1SRy6W3DHRWBTunSWvDTSxlKsJKGXef39nZvMViCgENlHF++p4vmYRoD7WjH3
 XJOK822t4v3ck6E7Bpd6Dnwj42aNwlhPQlbkrpcc17ghkm2dyh7Ac8w93LaVt/ujjW0a
 6g+4rs5wC4Me6bM7sUF+tMdUFwfZP3MK8vSwtKF7gMHUADugLKWr32blLUNga7w7R9p9
 6DZZZ/xrH72lYH9i5sgT9iX7XtBM2HO6fvZg5WCPG4fPwodiGhNU113G43Qs9nSGHj+A
 A7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789421073; x=1790025873;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=v5pdoJwMTGNtoLzBt4HJtZy/CksnGVdvraRwPt0aZs0=;
 b=aAYWinmpsUINxJymsWJtEQZucwkrxSfn4YXn8Zh3DSiW7XLAMlXNOgB/oo4hHvG6Td
 TojoZZW9sXo0r1HC6CMwIYGNoF52eobq/ivQyNK1V2rveqU3SzeaEHUK8kIIDdyCQV2M
 YzCzmnESbl7aEs4QIRIam3sukyG9+en4XqyqnTdskLiOjCF154P3dclzPgHaN1cn470d
 kDMREYjRBhKgfztVx0rldYqRv3KCIKwRqYMr6uxQDF6VafgZ4mUmTERF06cBVjXtfR7f
 2+FFcKA6Bi4xMUpogUDRj23ekZqELwz4zri0DVz+FnZpM5DBiHklsxL6t97IYJCAYVmV
 hgGw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB4PSrmnsgkouHP7fGWEFHGKQoGrrKgscHdajpnk63Ck498sBv1vO8iKzCp396deqFJNgNWNn+wl9Q@nongnu.org
X-Gm-Message-State: AFuF++mgWTSvsBDL7b+sJBUkFqEt80MApobOwuSuLl3pw2f1CjhP82MR
 UZo2xaBjkJIztb8hlOee2lmpqyBdL83/9MQHMw1Cin6sv6MwR+awRASLTHnv7Cr73SwI8EWDxcH
 C/NhdzS3VAqqyIBsMaAo7ZTrv1ax6/7Pdw5RJrgXE71U4bpVE9/kXmq6cxA==
X-Gm-Gg: AYBFou2li3+Nqq7MbnjvSKXkosox16qGEyN9Su8mXEuXJeULOYbDE79vil0qyv1SNrz
 NMPgzzYaR29TvSG7AqYxm3ogMuG/Y0tSjqHvde0AZ/z5xqbB4T5BLLpbe9pN5eLMx3KQODnmQ1u
 qFhAKfNfG5FDQ/9Y5hMkcDJIpH7zLgf58Nd0dBW0AD5XSfv2OkcoFtF4a7PGf3m2CJSFZ0qTlDJ
 W9U2U2xGPZxpf7mWozkZsUUvP9Pe0z4GRTC4fe/+f+rznsOSOQ7I37x/xyXTM9EHxQlczPbo1I6
 jbCZtQXwsjthrUSp6yyQo59R1Z6xif0cEwZXyXj3VESNiiGgvYmsoZzQv6jgKTBXSuXOTqoDh73
 /SzA1LQarT+ID2Gnga98zxlxBkaqShMR++MvhRQG1ZK5GlAg8T0YS6yHXRCvnczwhDKyg
X-Received: by 2002:a05:6a21:7a91:b0:3d3:af86:fb95 with SMTP id
 adf61e73a8af0-3db406bc40bmr9182667637.27.1789421072799; 
 Mon, 14 Sep 2026 14:24:32 -0700 (PDT)
X-Received: by 2002:a05:6a21:7a91:b0:3d3:af86:fb95 with SMTP id
 adf61e73a8af0-3db406bc40bmr9182630637.27.1789421072343; 
 Mon, 14 Sep 2026 14:24:32 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33be20c67b7sm1966343eec.15.2026.09.14.14.24.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Sep 2026 14:24:31 -0700 (PDT)
Message-ID: <e5bc128f-5a99-49a1-808e-fdcf4c5d9e53@oss.qualcomm.com>
Date: Mon, 14 Sep 2026 14:24:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/17] tests/tcg/hexagon: add decbin MPS test case
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 sid.manning@oss.qualcomm.com
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-18-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260905180949.1852673-18-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDMwNiBTYWx0ZWRfX8Rl5rqfv4bCP
 /H+VSKs06MiSsRadqGZjtv+5oxS37h21OOYOBpbmT3S0nnWeDAKfIeWNLECUBj2I75XCIKCGQn0
 BUJN2NztsvrLZyOGpAKU1GGxD4fwJOU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDMwNiBTYWx0ZWRfX+xmxl88PA+Xc
 RPhB0QSu1axn8qaFVD9mcH77xT8MxH1OSpWvU/1TXOCfT1jH4DEZg4thQCE5NdvUGCGNqKaHSe5
 CPcrUwcCG4nVp8fr2T4BzEZh4LY8exJmyD91W/Or4/RrMyb/6vJmSjFB2/eBgAbgjISj5VSpGkq
 k5n9zKe/hOTb+qCECYZl0QzxSEjLxdLfEasDaZ6UBz7vPlUeZP+oys8BjkDio1sSPdgbUR0rP1d
 ZzfGA3Lmmv3teEExf2/d7oHr07gVfKX1LrLnvhwDSQmRYHya4nPAw5V9qEFxekaBKs8JSvYyXRb
 kgN0Aq8fgdlnfM/Iz9z9hkI2yVp2RvtT72HNFd85p7AJXxpdWguZjOyUVrce1QReHXqs0xknKm8
 W0u/DajlVueW4gHw5GEsXU2ImID2kRooUd/v080qSVpyXiBWUwQos9jA4N6xrcCh6ECrC3Yuhg8
 U0yqqN0rDdbf6w8bzNA==
X-Proofpoint-GUID: 3U3OjwQP_k2oldk7mRwhcqBM5wowJRUr
X-Authority-Analysis: v=2.4 cv=Ie4Symqa c=1 sm=1 tr=0 ts=6aa86611 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=6-oWqWCVDn8apu6pg9AA:9 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: 3U3OjwQP_k2oldk7mRwhcqBM5wowJRUr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_04,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140306
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

On 9/5/2026 11:09 AM, Brian Cain wrote:
> Add a decbin test vector exercising the MPS case
> 
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/misc.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

