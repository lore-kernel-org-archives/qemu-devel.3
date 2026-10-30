Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7F0F606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 15:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YyoRhMtR;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=XMk2JCHO
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMoba-0007N2-Bz; Fri, 30 Oct 2026 11:33:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMobW-0007Ls-Rh
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:33:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xMobV-0001vs-6A
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 11:33:18 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69UER3KA3515284
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:33:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 i7rZLEhGS4mZF6fcOmixOW/Wrt74csU1oin9Zq23+TA=; b=YyoRhMtREDgUfuOH
 tQd9536Y+vmTuh7D/E828dCcpJ97XQCU9gj9V/uQapJzR5n68RwLyoySMlmpcuE8
 Y6sn/LGhEPNGSOoQz9oH2nqZzFNxEeQpL3ucZR9GyJTYAUKprHISigrTds91nFZt
 2oz9l2N3NOxUjvW3pS0c3AQouhdoX53l4y0+MJGe/6F+F19bdMcQJrRq+5CdpG3h
 f4YvzKYoSVrK7rQms/yXprw0OXQs0fuFUsTOnp9maNB8C6VFvC5BuxdgaJocp/uO
 EvFfJyp+uGYySAygZtjE0t2nMYeUJPgI/a8RcOduxmgvjRyz3uSQchg21KS3GzDc
 2qcKtA==
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hme6qktb9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 15:33:14 +0000 (GMT)
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-7bf5c02f7a3so188396137.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793374394; x=1793979194; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=i7rZLEhGS4mZF6fcOmixOW/Wrt74csU1oin9Zq23+TA=;
 b=XMk2JCHOvPa8OW2PIr31w6W3xkhdsQni3wEPTa9aduwl1XkXS08rXbfW9OlDieP0NF
 41g/0Tnzi0Mbvqp5Kgz9+ZDvQLGxjiaR2ympFl0Is8UYKhxbp5quuoD6UneXtNC0mEop
 N0aAt9+NRt5kkUQCzBK+tdomPGwBbvYvB3h0xhff6hjh2SLG0J03McUEFIZ49Igl6XPB
 uWK4waXsBzJPr6o9qsGpw+Z0r7yRIxzzEFuTaBj2b/5SFsHx9/LUYVu91HZgiuRH6EK9
 RtyjM8utEXaEwlPsPODBXIhKAxfnaTgn5LLk7ONE0vjpF5xI5xGL2oGIQErnVnTe1aJK
 7oyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793374394; x=1793979194;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=i7rZLEhGS4mZF6fcOmixOW/Wrt74csU1oin9Zq23+TA=;
 b=NKXg1tsO5pCITgm/7aAZoAOs/ZJGJjgH6Wnpy44YSFrqd9fMaY6ASZLUxIzERjjkkc
 OoXs8Q/YH9V+EjxR2j8hfCfoVGro7c/fvqo8QuZ2/OVKrL5iuePykVgvGF5Ph0zXoWEg
 i99SCLwKzAl0mkau5uekvXVYEspeD7OSkJKcp/SJPiqGWIHRJTVKbU0NWo4BKvYE7PKO
 FaMgIfO6Q8+cWm6E+OdcP0OYzj54QVPEbqAoYoRBB2euptdb8WtgOQaWH+GRyKn7lCgy
 E4gRiaSPdDzNqoE5ZkMnjE/lCOVWRe9aW7TXqEklCq2d54JzFGEA/GEuhhPiZJlh4OMK
 qdDg==
X-Forwarded-Encrypted: i=1;
 AKwUvBybmw4dEdTZgNWWAZzRE9GZrySeOYWyGcqqUKN2z01U4X8dfMBsMXghMQfkpBiZJz3wVpbIc9+KBzg9@nongnu.org
X-Gm-Message-State: AFq9FYLFXOT+Fjvs9nYtgQUTDp79oaIwW41W7awLFGZDU203eU0y54s4
 xS0DEjTlkl/9OyFMtcwAR39RMZBelQASDFf5MiFIKExiurF2fxBi6I03jiNn6t1QABYYhTdsX/Z
 5a6jPssTG2OYeHyNxT5nXCVMzieBDv1vOvOt4fK6bVnHxDsBcjo7YENkbRg==
X-Gm-Gg: AYBFou2/nIicRYT5UVWEwudKiZcCX6GEABzrgF6rbaHVLh4yeNje2EN20SsdhfTndJm
 6XDI48mB0eWfDSRYoPgL3Tc6qTfy1VAT9q01ANVz9thdnZBVbWVrfFjaIHQOBOXI1ngLsocH3mf
 LRg2wQiu3O4nADaed5/R1LmkVyz+ZchZ5/M9NN8dpcWlWpbjxYFmbDynsdizieBj9O6PpWUfZo6
 4IpdMF+gZ45OLMZp40/CqR6c5Fhab1m1eTYKYAiO6M4w+f/AoQSAFlMHWi7DtkQhzvTLhqmSz5o
 lf3VIq2Kg1hp3xQbltJWJc5BcH6Sq+XVucjd6ngR4+MFbFC8GHMkMmymfDcIqVXVyF3fMIInQeK
 22LpvH3hq+MyXQmm0VPlHFBiAbhxZKjscQtx+S2Vwmg9a16ig3ONSe3Akt3y+6p0yGrojfcHJc9
 8sBL8/InjzC/8/VaCgbia17Rw=
X-Received: by 2002:a05:6102:3fa1:b0:7b5:4700:3a58 with SMTP id
 ada2fe7eead31-7d072658d05mr1337832137.31.1793374393633; 
 Fri, 30 Oct 2026 08:33:13 -0700 (PDT)
X-Received: by 2002:a05:6102:3fa1:b0:7b5:4700:3a58 with SMTP id
 ada2fe7eead31-7d072658d05mr1337817137.31.1793374393181; 
 Fri, 30 Oct 2026 08:33:13 -0700 (PDT)
Received: from [192.168.69.229] (82-67-153-177.subs.proxad.net.
 [82.67.153.177]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e71b80ecbsm3927950f8f.35.2026.10.30.08.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 08:33:12 -0700 (PDT)
Message-ID: <d9efd673-8ed0-429f-ad1d-c2b8f13d2b0a@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 16:33:11 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/31] tests/tcg/mips: Group DSP acc tests
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20261030150202.61556-1-philmd@oss.qualcomm.com>
 <20261030150202.61556-2-philmd@oss.qualcomm.com>
 <97b9f9d6-39af-4e75-955e-8d5d0bd8df2a@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <97b9f9d6-39af-4e75-955e-8d5d0bd8df2a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: MC0tFtdQqMbFfdgNKh2oJsmjjyQM86ZJ
X-Authority-Analysis: v=2.4 cv=KLzPn1Fo c=1 sm=1 tr=0 ts=6ae4b8ba cx=c_pps
 a=N1BjEkVkxJi3uNfLdpvX3g==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=XlSn4FAP6AY64eeiKxIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=crWF4MFLhNY0qMRaF8an:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX8/ChmDSDgkES
 N2/DDLj8RBWVhLQxelReOOLWeGIuQvWtN9NMKOveMH66KT+0IOMEnp0L3/zx47VJ1QKTtEo5Cdq
 tiUxRfX7CyFLdEv0lXpYvIkcpfJS+VcRz8nUg3PZcbA6XezdpqNlipcd5EJLLraAavec17Jwufk
 mcDQBHoTL90CYn5WUpTKig7LbEU7MOgqr07brBFphztDh7RD47TqY8dgdoO3Ah1wNki2Fz6UrLl
 ZXcXk3Y98MMyFaGBPMiSdoG6o66lxUc8DXvD+NW+ETilxG5pV6kOwIx+s7SMV0/rVHeiQvq1xeH
 2/8SDzMc44ynaPkY5Z6pDhACM8+HVC67FU/Jp/XJWIHI7FX8BzElV2EHF3U8SJgIJS5ST81b4LN
 iyFuSyO0Cc+aK3fS2OFwkQwzz448rqgbgcncGA2LR4eurc8cMWKcVLgyjwos2R8DNee+bN+X9v7
 RnQvI4AY9En6HdVcTgg==
X-Proofpoint-ORIG-GUID: MC0tFtdQqMbFfdgNKh2oJsmjjyQM86ZJ
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMwMDA2MSBTYWx0ZWRfX/OVVvCh6tsik
 iaVvnP4JUNUZjphR7KAcy50u1jc9c8D1JAjOs4V4txe05KGI4jvKuwj5pqZVNqShmeKVm48N6//
 sUxCcZxDRc6/qyOkN32LbDTGrtvkUj4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-30_05,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610300061
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

On 30/10/26 16:23, Richard Henderson wrote:
> On 10/30/26 10:01, Philippe Mathieu-Daudé wrote:
>> +int main(void)
>> +{
>> +    RUN_TEST(test_dsp_r1_extp);
> 
> Forgot TAP_START() ?

Oops thanks...


