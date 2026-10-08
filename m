Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B591DCA6009
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 00:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEbpM-0002u6-MD; Wed, 07 Oct 2026 20:17:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbpL-0002ts-Df
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:17:39 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEbpJ-0006bj-L9
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 20:17:39 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtbJT976992
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 00:17:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q+McupxoM6BHIuvYYP2BdnMaZS/uAFY0jmDuQf5dctM=; b=XN79eGwJYYu41Z03
 /aj2tU/XSpfEfMvi352FheQ4ZLEn5qYfnwwiPF+Ca0kWyiHX7F/uuUhs91xfBjWq
 QbsTVUuKAcqW7hC5PZa9BrQO/OicwbdziPF8SW4oXmAWs95TlWW9+JZ3N8tecw2f
 gPDeUyUneQ/H3lNEpkkr+LljeHFGO7u3i9at935PtJl9uJLMfAXD9I1KV7hEJht3
 0vCRQGeaDFfCFn2RAP+1GRQ3XDII4X8kDSu9C8ilAM6GQRPbloJFsz02ma/h3MUZ
 crteAcQg8sDbfrt/GRxevZgMoKbFXbZYmsf3U56LNiIIL1ilAj1DA+1Yze5aF4ss
 lalSjw==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe38bhu-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 00:17:35 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-34ef5fd7934so12454697eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 17:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791418655; x=1792023455; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q+McupxoM6BHIuvYYP2BdnMaZS/uAFY0jmDuQf5dctM=;
 b=QEdieO+rabsXVQ+f04wObvKS0cVioduME3aYgZ4H621BfqjW+Dv7NbxqKPRCwmvzpA
 jMfLEabMVd+TNSBFP+5nnjzp4iW8rhYHxFXSKTlINYXBh4oD+XYeDQ41+Mrx13ZWSCqC
 THGQeU4s2I17t1Yx3y1ztH9yynEYC7PX9GGtRv1cGSMR76ORu2S/CT9BddPWwsG+f68w
 mypQuYyzTblZsqYwSz6Gn+2vFlUDZDhjPjbodTpZQP/pK2+lVuEdW+k6FJAknhDMt6HI
 Q1TjvWnAsJFRrj22UBjDeHMje407sB9ScQpOASvR1SDQOrL+A1Jf9wCxBRxr2o736wVb
 Doug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791418655; x=1792023455;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q+McupxoM6BHIuvYYP2BdnMaZS/uAFY0jmDuQf5dctM=;
 b=Ho808bAvqfngMn1Jb7FytnBH6L5EifA7r/cJWDoiIX1gxKL/LTjiLrHR/4MtKpquT4
 vOg8OxM6PZPfi0a5piV4cMrIX2a/9guLQHBeFPKNvUn3J89JPJuQV9yrHvVT1+GJW3Hv
 WIJnTDspYGzJetCkk8vd0tzB1GHVowkka+zqumcNkmqt6Jk/N74o+8w9SjA+c19Z+wyY
 G7OguoPYWmZPm7vEZKmYHdWNwBrKtE3V3Wr9UtNAqgELfWtPNRcQxt1bxbv80dCpzEel
 zV+VQtnKfbXEKyxc4Vs43Jhb3IHvEbR5WjbpAG8CIGsTOyVzwJJ5wAH28Ls5DoAPh6t+
 0mKQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgh/AjpuylpKEdW9aaJweOhbiAGCecRFNaFkPxFjIEq5ZfkWnzLdUlyQuz9tH8bqAJmVJEXttpcahq@nongnu.org
X-Gm-Message-State: AFuF++m1vIce6jsZHdIMqBvQ4hccL65pwMYzd1JezzeqWhjjtVy3WDkU
 VE8E52NN7l85mJKS5Tlb8PRRC/BLKb+R832MSOZjhB7cevG7kFFvt76lhtbOIg7w1gbd21SDTQg
 ShIDbRm36UbC0XArq68sS9wS/gXO5YfoUcp0JsoBmg/ueLEaqOr4G9BP3UA==
X-Gm-Gg: AYBFou3BJ2R+nsPw8X3785Tg6hxz5vzpcmZLgKt2OukJ+a8SAZdLhaiy6HFAt7W3xSH
 vC8+fZOPhHOYxA2hYTU7qsAZx4mAPXTurCnDvxPHKPOS2j5BY3KC5IP2SIupArn2glbPrg2mypm
 iK+5FqwFEw26R5t1zp0KWFEH/TntiNxFGJOP7MIhfEwwyYOQIC+QZ2gHwVdZtcew5Chq/9UQV0o
 x+3NPL1/QsEjzxn40LEfuIN4KxRq72g0IbgUhGXwFsHS42eMF2GHl30BB1BeI5su6es4nT65n+m
 GxUr+6abAxVEWs9pwPyxUuXk6sV/Wk5YFokWMKr5C9t03cCmHFSbwqUutH/hfggUUZxCcWBELBF
 MGokwhjeFX3kP2PBOGLUCOJsDRj4CqLzdrHVER1oW+hFrvgFpFxbaDHeve37i6vV3x1w9eQ==
X-Received: by 2002:a05:693c:2803:b0:34a:586e:84db with SMTP id
 5a478bee46e88-3515db9c8c8mr4265279eec.2.1791418654982; 
 Wed, 07 Oct 2026 17:17:34 -0700 (PDT)
X-Received: by 2002:a05:693c:2803:b0:34a:586e:84db with SMTP id
 5a478bee46e88-3515db9c8c8mr4265186eec.2.1791418653317; 
 Wed, 07 Oct 2026 17:17:33 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515af65b87sm11434562eec.16.2026.10.07.17.17.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 17:17:32 -0700 (PDT)
Message-ID: <4b44dbbf-57d5-4df5-8d3b-3dd470d6b3f9@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 17:17:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] contrib/plugins/bbv.c: Reject invalid intervals
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>
References: <20261007-bbv-v1-0-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
 <20261007-bbv-v1-1-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261007-bbv-v1-1-a2f521a68fdf@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=J4s/fwnS c=1 sm=1 tr=0 ts=6ac6e11f cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=BkEA3yTnA327cz1XdUgA:9 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfX9ImLO258s9uy
 VZPGFB2sqFJxrN+sAAcYJ1FaKijJkriFtdymBuMdHME27mAmgMdivIyAH2XN0a1eQOQX8uR/6VY
 01cqJhTD5zCdy+ikdKvDdaW23Hvmurk=
X-Proofpoint-GUID: ecuMqTGorBIQ5zsvX74hWvquO-4I11Db
X-Proofpoint-ORIG-GUID: ecuMqTGorBIQ5zsvX74hWvquO-4I11Db
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAwMCBTYWx0ZWRfX4mjyCfm6M+t2
 MVkXBuy0mmz4EcoVyOfU9L592dSJHUQtsasKERN8qjEZ3DBmKR4I0htw/Kqq6qsYF/knn64IzlY
 bu8FzEvspIlEwwIjC9fynycrRyBkTZ+sccslSYxS1V+P70sHxDpLYIkCjkXqrlvVlHRZc2bYCBW
 mdYtxyjS8z5XI0bTiVuAIAv23p4SLaPz6HgYpL6nFcX6UlhJraQI0qfRep+4p6VBKwPmdeuMNWb
 9t8KoeIbMb8wDTAd6WQM+9lT4ieDsSpfSphTFifHJGpFv/9Blsk10L1AI4Rb7wDBTtV+jdM11BQ
 5BVXGL6lKLtjbvnE4IZQ8hHWQ+U4UIIVkgwnGLuR8CXViih6NFYtnDGVK+n7yiVntlw5kAFsUVd
 05f+hLdkka2KVpGVj4ciP5VGcuzI5n0kRBhpYSfNBk/yBJFlV7JqujS3gi39RmE6W1+1c1bqpM5
 Ow+AiDs/qKlZAUVkKHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 phishscore=0 clxscore=1015 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080000
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

On 10/6/2026 11:01 PM, Akihiko Odaki wrote:
> g_ascii_strtoull() accepts a leading minus sign, and returns the
> negation of the parsed number. It also accepts zero. Reject those
> non-positive values since their semantics is unclear.
> 
> Also reject interval values with trailing non-digit characters, such as
> interval=8a.
> 
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  contrib/plugins/bbv.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

