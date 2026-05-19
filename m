Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4CE3CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:15:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLDk-0004UG-6S; Tue, 19 May 2026 10:14:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLDc-0004Sv-RS
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:14:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLDa-0000wW-KB
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:14:48 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64JDOWDv1146729
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:14:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rUYk+Ds1R29HLCRXyEkeEFaWcR7WKZu+oRAOKOs/nog=; b=QaB3c6ejow+AIm5K
 3JBLYj1Wca+XjE+G8PFhvbG2zkC+hVNKZllidSrN4x83O6BkCUtq6Ohan6l8bviR
 oX3SKEjP0XUin0AfYRRiNt86k+Uc5qw/XLCQVreHUwJYTi6TUubRwwZqqhV5hpH3
 EzJprr2CY5XZgQhA4KKkKpyxr2Wd6180yCZJfbqKazY4zEJJYOdsfeKCltARFu3d
 Yd1KtVz5GQEPlM9bAHffatG32VkxAMvrLpn+aQjJJWo3/ImZCriE8AETuA9lf+82
 tecvXAC+iZ/UFP+l6kUFo3EBOuXDr62Ices0ybj89rgsnbGXaGDQal/zEm8ZWjLg
 JNzXzg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8e7ejwkt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:14:42 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2fded513994so15990922eec.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779200082; x=1779804882; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rUYk+Ds1R29HLCRXyEkeEFaWcR7WKZu+oRAOKOs/nog=;
 b=ZU7M7QOY5Q0Ox71avGgvOMkPKBvWD24RKvB0apjV2pDHgSDomMATwgIMkMvOSsuGn8
 zNVQ9OhvUkqAfU+hP4GqsBGtW8kvNDuodsU3E3hw2rp2k3mWAwWci/+FOLvjH7dEDkQf
 eWz2KAZZNUbvxiHhhP63+rPAgTEnqCurYPwpxs0ckSz2kTtqcU9qa2fD1C5ifHKvFG7W
 sM6BeJwj0rd6HPaFJ7yia+9cukVVAYrkFq51LeUU8iDOenqZsiN25pJA0VpGcSEejQpn
 iU2OqwRdeuFNCtA3cvX9IrRlCn/+43n7fllYf7tEipMc1DzuYYs/5U1IBjpphpeWBFLf
 rWEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779200082; x=1779804882;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rUYk+Ds1R29HLCRXyEkeEFaWcR7WKZu+oRAOKOs/nog=;
 b=TZZAPTipr+goczFiyQj7ytBuqB9tHLbtpN0FJ0vSMjeGquy805RRXn9OySnol57/kO
 JjsBPfEC+oFy7MXjGRwAMwlx25UVZUeN5zZQ8IYwDfzU+1aGl/rrkVJ8t/YLEEBsQojc
 Vk1Ll9KBXFUCmbu27pftefDpJ31zlrT0u29+KLnJv7sdqk5syUuzEdO+3vKE4jOVuseo
 ibiN3Fk0AcS/UyNTlzp178UYXt2Pl0iUowg9OjGp8PltFQGOYv0Zfn4DKliCN29YRz8b
 JyL8BhQ8vTlER5amXERO7CQtHs3A1w9tFsFROCluryx+uJdy2rhNQKa+uBXXXZQGUcAV
 9g2w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+TjFoPiCL+7uzpgeUD/Din92JXVn0rhhlWcj4eeFxny3EpID5ctcyHLkfBHGvyizqKvuCrET6E6Xzi@nongnu.org
X-Gm-Message-State: AOJu0Yyl+oJg77DUNRZQ5aztbyBuZtB4AothBwqvQvS+HSzqVaQX9O1C
 xFwgYpEFUfUANZykq3IP4Usw41sIqHM/t1qJfmmM721EayzFPjrrtC9cBmvJsBhMN1dUoigRt9w
 OBus6cbUgf8LNedLQM6ktyVpeoxJHrnt42ZpnEft4UAUhsZulmu4yTYMy8Q==
X-Gm-Gg: Acq92OGHWd3/GGL/XuSRGye3XFpKTleTEcSxCQ93KOhABWGjhtS4Y2OID/jDSFGYmwz
 gGe5HdOSwsEmFOHpbUx/RsnNwrlSWiVjDyK7L8Oz0catllemj8WtMhvXcWECZF1+h+68gnw0/TK
 puWoHrW8kyqitnFdmBr/dbRgkg1OLgyektNoS5/uRJnWFtL81spS5nl7EJHx4OsZAWGyGpdYKmP
 ZzOk0vbqqoptspTaLkd1sFjpo5jcMBpOnxB+OpmlHFAKgKFl3j5I6awalTTxX0EZm5aUjVifVz1
 SR3L1ob+fUaHGiBWpU/Dk70XAKza9c4x5mP/cwgvnvKVn7iitCbZNZ8M8wZ9dRoq7BKiUf6y8Jr
 73isr8SfPR8Zu5qVI6N9RPaBiKYOwZTcgWB8uEVqVfmrEOngxK23mXyI=
X-Received: by 2002:a05:693c:2516:b0:304:aca:35c5 with SMTP id
 5a478bee46e88-3040aca47f0mr534532eec.23.1779200081741; 
 Tue, 19 May 2026 07:14:41 -0700 (PDT)
X-Received: by 2002:a05:693c:2516:b0:304:aca:35c5 with SMTP id
 5a478bee46e88-3040aca47f0mr534517eec.23.1779200081215; 
 Tue, 19 May 2026 07:14:41 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-302978b3cb2sm20864192eec.30.2026.05.19.07.14.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:14:40 -0700 (PDT)
Message-ID: <bcf1317d-6c28-4ce6-93e6-c1d50b98de13@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:14:37 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/16] scripts/mtest2make: ensure output has stable
 sorting
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Kevin Wolf
 <kwolf@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260518160051.903616-1-berrange@redhat.com>
 <20260518160051.903616-7-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518160051.903616-7-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=Rt316imK c=1 sm=1 tr=0 ts=6a0c7052 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=e8JxHWp-08NfHrpRW_UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: OCyhE6AMEkzKhQq4vo13WGGoYzKPRtL1
X-Proofpoint-GUID: OCyhE6AMEkzKhQq4vo13WGGoYzKPRtL1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MSBTYWx0ZWRfX1TFV83vjRqAD
 GYoluXphT7EemrlPUJNv5J7wDyx9DcCRkmXIfus0ZGBc38muDpTn4iKmAH1xW6iDznIB+vmz74q
 kcvsV/C1oFBGPXlWgQ6HF+ivaZGIgzDvn1dRcVEGSRXpCuUfE8XyokxoDiG6JvCx6gqA0tve9PI
 7UNLTHnFAlNtSZhIWsftuYM+Sc6U0SzMBTk4pbY+Rg2PluOA3MpuQUO0QjOvwdOOfeGnzIYJa+9
 k9SeQ6Q0FX9it4VytaUCm4u2T+rK0csGxOy/siOzGEY97oTbuAWQkpc+fdVPNKzaG/jfo5ISyHC
 BaenhmUlvT0TiAvSX4gwhVk3nD2QsO5/lnOPjtJJO8CXWE6IhdZCyBVMUP2WW2rhcRUDXC1Plyi
 OmAvWUXSXf7i0ruS8j8wziY3ug3Z4jHHSnbNFTl70XrAZoxnYmq31AYKepwxre5OPEKeS3hkRIb
 EeyU0JeIucbLj9JbuCQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 phishscore=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605190141
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

On 5/18/2026 11:00 AM, Daniel P. Berrangé wrote:
> When debugging mtest2make.py changes it is important to be able to
> compare the old and new output. This requires that any lists in the
> output have stable sort ordering.
> 
> Acked-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  scripts/mtest2make.py | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

