Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EF18C5DF81
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:16:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyOug-0005jY-T6; Mon, 24 Aug 2026 03:16:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOuZ-0005ik-BJ
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:16:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wyOuW-0007rG-Gz
 for qemu-devel@nongnu.org; Mon, 24 Aug 2026 03:16:03 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67O67ckN1662617
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:15:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 MHeNGtgFJpyf5T8VpXNRGSnIf3xjTNKWVLxscsl3A+E=; b=ZMGMiw2C0q3oPWj/
 k1PJjwTZqUdjdfQafHyZ6/z8rgW2D5oZ+XJOSXDee/CPBkmXbeCs2Wlczo+xsENi
 kOAfuOt03qokosLV3eSpF3yTZ7m3rB05UMPzt0gB75ZS8RtUMS0JA+szRnBY+geV
 eZCRKZagxFtPMsdqTwOyyFdbvofMSe7xXG1KPAy8+oOJZrEAjIvK+ojjKUb8feIo
 fPvfuJ0ORMZt05aE3xjAgyBWOFNuxoM3z19xr19JGvaJzMyIV0OxYgaGqY+dpNb4
 g54NeB2jIkpEwV351dfLD1NGbjNDtUjl58S6RPYlDcvFWjdWaJs+glUr+fYg8PuN
 P1LZaA==
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8gdsgagh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 07:15:58 +0000 (GMT)
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8e9489f62bfso36264306d6.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2026 00:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787555758; x=1788160558; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=MHeNGtgFJpyf5T8VpXNRGSnIf3xjTNKWVLxscsl3A+E=;
 b=hoyP31f9HVLbeegkyOHY4naCHD4YBowArY4ncKmJQiMtEhu0SOWjfxooeeMazx8WYB
 lHD23Xqrbkirion/5JueosUMkn1SwYkVuuyKu/q/vXD4H3uG7o4BBR7EYh7WmPOqPbZW
 rwfhJiUvUTObgxkPk9nkBoNUeb89VvqEcZTePmJ3oC9FEq54e5Ag6gBaLdK2MFPUPeQ1
 LBK3ZqF/qSqJ1PykmRCfuDc43BT4dDCvCeHkDnVX8E9oxpjpTStyAgQgwBTQqYPYJlu8
 Sb98VSmM19iGqWv5I/N7+yvnqwIVVEHeJymtj2QlxENGq7ObmDvcURvlpTBPWFJHNiWd
 cv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787555758; x=1788160558;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MHeNGtgFJpyf5T8VpXNRGSnIf3xjTNKWVLxscsl3A+E=;
 b=MTXC0k7GDXxp/HyHoZMHxTtZeAkD+RvCfcqQ6hqn/pQ3woszin1AYwhR6sM4XG+JAD
 V1CUO7iKAu/RPN9JCMdi+bA86yGJk7J+iA7kUXNJVlot/ncAvgyjI73yk7Skz26vpD2C
 g5KD6N5i0nUSGtj26gyh27RPyODFgbmzyzC6nbxa3jONbrLW2RRcas49tFDxRD1KTfu/
 0PqRHOsOK0o4u06fRecazHFXCUek8Tq+rm19snitVZwcQOZz8hpqfLRI0cTXHlf9fltH
 szy6IpPJR4i5wDMFpvu00u/QcKC9yuU/t32Htt4oUx9GxSOqIcgyKSzyNQnKIDNqmj5J
 0S5A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpSEKhkz7htRwg2gETEX2vD3SsB9INEiCNsfbNuwqqx5YOsCyDunuMqoaSqTMZ8T9C4IwTOQXgv0zrL@nongnu.org
X-Gm-Message-State: AFuF++nP1P+49n8zAT2GUpzwQVabUCmKN7A8XDQT1h6uOhh787lXlkks
 qarQvxySekjBn3j1hZLIbXJFEKg55Bi7FzJtrXARWpLXRsjoLBjzazdh/9dRY6RpQYYPZDVsSpT
 sMiSx+I8kO7fEUEmFQnwEq8hHd3mUpHzI7SrKOr4SLaT5LvRJ9L3itqymGQ==
X-Gm-Gg: AR+sD10kiZgLUTarmj8DjQYYAcMTqtq0fqxmzOAgrV8wmI0EwCqsdP26bKa1JGy5cLu
 ODIE/T5Vp0gHgWFELbFJP53UKYq9OWKF3XJNnif66hTbZa6MzkNEi7mqHKjyRvGxnBk03XLxigh
 nSaCs6sglpSO/vLNlxNbrxdit+JzT0RxZy1OzipZs6Cp4E0AtET/wo4DI+l8ew37IdnYjszp6Ap
 FJgEepBMVO8d6kEwoDJW3qWULBamlEmAIXSxxnoeTmFEVQgaEH1lxkyb2NNVgYrJaEXA0njZciM
 NvSl2ybaMw4SoZHpqUS09E6lQJNeQLPGdWW/34BmXt71YuC0R7XABixk26uw/22MEqjrxDkdQ55
 uLUPKNav0JQAqpZas/G+d2aTrRnDWYHNhDB5WKNPL2wj7
X-Received: by 2002:a05:622a:1311:b0:52d:824c:4856 with SMTP id
 d75a77b69052e-52e09cb94a9mr163105391cf.31.1787555757911; 
 Mon, 24 Aug 2026 00:15:57 -0700 (PDT)
X-Received: by 2002:a05:622a:1311:b0:52d:824c:4856 with SMTP id
 d75a77b69052e-52e09cb94a9mr163105211cf.31.1787555757574; 
 Mon, 24 Aug 2026 00:15:57 -0700 (PDT)
Received: from [10.254.188.74] (132.170.88.92.rev.sfr.net. [92.88.170.132])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496738e8bsm1020414566b.44.2026.08.24.00.15.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 00:15:56 -0700 (PDT)
Message-ID: <a748161c-bbf6-47a0-aa21-468e17750060@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 09:15:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] python: allow mypy to run as the current python
 version
Content-Language: en-US
To: John Snow <jsnow@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, Michael Roth
 <michael.roth@amd.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Cleber Rosa <crosa@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260824052859.880475-1-jsnow@redhat.com>
 <20260824052859.880475-8-jsnow@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260824052859.880475-8-jsnow@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: dob2rPwbq_SAxCGXj7uUijoTQtU7L8AA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2MiBTYWx0ZWRfX3SIN7aveuZi5
 GXg+zvn1qBjoov2h+0kaMbIvL5Eh0c12DKQPZR9OVTxKKP8wrdkSZziYt78QIlnGVkbgg6lf5xM
 lIUDVcNSR8Me74OZv7E3uJCTrH3XlWsVpitHhMD/9PFEvy5lxKXJouwkMjDrHFy7pkVMGrZKDPd
 8h4fa/DJ5jmta8LBcn83/vgvTT1n8ln3wzW0gLJMUv2e9+MpoOdh0Owmz/r31hxKsZEAK+oQBRw
 7ReN/wx5dF0lYhYJ3Y9/fn6HbPA06mYcaZGjncz6wqIbgHFx9eXJ9nGExhib5TqZDFkWIGKAPZi
 eAm1OiEl+7vRZSD8tdnPR4uYRiZwxmCC6kflxdydBsMJZNrxDC4Zk539Sw8BzwPSBFCKGsmV0xi
 H4XclKWN3mVRq4v1VSFI7mbjWiIyp6ruF475lmYX1tW+BwdFINHQXBYEHP4KtvNpPXoyU+7qbJI
 WC86CQucFgbix6ErUCg==
X-Authority-Analysis: v=2.4 cv=Fqo1OWrq c=1 sm=1 tr=0 ts=6a8befae cx=c_pps
 a=7E5Bxpl4vBhpaufnMqZlrw==:117 a=k3i2zbviP8V9/5wfVjyM+Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=pJ04lnu7RYOZP9TFuWaZ:22
X-Proofpoint-ORIG-GUID: dob2rPwbq_SAxCGXj7uUijoTQtU7L8AA
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2MiBTYWx0ZWRfXyJ40c6zuNzKJ
 LdX1DiNYhL+/LIjR85GtXvzG1+NW/23V14DphJ6qtZeiVt1zmqBDCGTF7rSTEnpaeRSxEc7M91r
 uTemjTM+XPbm072tt3WOiSd1X0a6ZUA=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240062
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

On 24/8/26 07:28, John Snow wrote:
> Currently, we instruct mypy to run assuming a specific version of
> python. Lift this restriction so that under tox tests, it will always
> run assuming the current running version.
> 
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>   python/setup.cfg | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

