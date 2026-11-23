Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DFC606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 17:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EdVg1DAW;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=b9C5MKna
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVXa1-00035X-3M; Mon, 23 Nov 2026 12:11:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXZy-00034a-9x
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:11:46 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xVXZv-00025G-M6
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 12:11:46 -0500
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGkj83025226
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:11:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Qp3ZH8FYZUKqpSfnD6oLIFr7AHh5cCrHjTiKxCYtRgU=; b=EdVg1DAWBfZz4rdq
 7BwAYze+nbBXLISz69KdaoUswO5xgp4ogVy3sNKOzSNDoxcsPBpRWcf+CvYIObv0
 7VS1kjcYLJ+bQ2vhXaAwoT9g7Tin1VeLYZgchstHRMtjBlajIsLPwtiPKuDQCqB9
 HbvwatfwsgaWIzPzGAS4j/4UQUSjv3TWc2MPmet7vIiDo3LnrVAntOIl38UCddi7
 mZDz9Z70FyIOEFpXSd7wUsSan08DG7wD4sY04NsDdp9VXrWrKHxgZnVw2MZAvhEv
 PIdam9W04aoDpk6exwrZhYrB7iBcQNRSmDcvHyE7vd5c0LsS7iq8EwzLQ8sFCEgw
 /GJhTw==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4g1paj0r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 17:11:41 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cdb869327e7so2971190a12.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 09:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795453900; x=1796058700; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qp3ZH8FYZUKqpSfnD6oLIFr7AHh5cCrHjTiKxCYtRgU=;
 b=b9C5MKnaJOaeBpNIwmQTcfIrR47YExUrgRLVWUNfN/lDjMu4ATb0dWfIoyueCa6JXA
 7A2BDOzZ6NWbhiotZeT45qDzIWSa8DKssO5v2N3iu5MZY/GRZscMnDYE23UmE3Ua/4PU
 r32wdImwJwfqMZWa7ZL8N8+2MZNZ2/DiStq2XuOMFrVtEDSNx7gs7cvr77uku7yJ4NZj
 8sTcoytuwfb61POXNV86BdFae/4Yzud3yVX3c5My1L90JbdtTXwWo0W8PQoajMgcDkIt
 CcmrvdmrGIpsvCXcfMZuGvGaJ5QIOtdHNcI20EQSdfaaa0XD98JlRj2+aAfwydWOWk2B
 hrJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795453900; x=1796058700;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qp3ZH8FYZUKqpSfnD6oLIFr7AHh5cCrHjTiKxCYtRgU=;
 b=su+pVcvKjmxFFUrHDmUdf62957ntmbFkakE6LgIt0RpPnniCvCKXpO5Lw1wZ0LIY85
 hx1ZoQR/eV+YMd6KWhIfFbPt0yZJvx58EiKHOk16YG8LeNtDLzcUG6U5m3OIqaAf7lTP
 zLp23Njp0Q31jtp1gRsqMzd8dY9b6paQf4n5ABTW4K0LJARnO2UomRX7hNBTLh3MT1xa
 thTOHwP3g8q2APjXS7BKNDd79Fk0xRpWOTIkoiMjO9DBGxQoIhXucv4vNcrUiomC22Yi
 Q7CA4axsRjRUVlLycgDH1Vj58f9vh0u0aXtmcepycRSsAPwTKaeGrmP/LTWa9UNsNdC8
 hQfQ==
X-Forwarded-Encrypted: i=1;
 AL+hErH3qofE+4zgfYna8uQRohTy2WO9O1Ed7Um71+UJ9wRJbFPjXdeWZgneLPDaBP5oWlbU0QTzDqJ/gPpy@nongnu.org
X-Gm-Message-State: APuU4Z9i1sUt7/t8DY3GtuA1LgYPsdP7SUOGiUByUR03Th3849uR+5P1
 XwG6NG0OVyktPUgL91jUeKzgXSdip7ZrTQ+txqr61zqD29aq8PWk3hDy3n6Rfgl/pY9S6xXqlWI
 G7lNREgvsQx38IO38q0NWdHW0z6+02HKfOzkGjCcbInYYTdcsI5a3FaqRWw==
X-Gm-Gg: AZFdTZeomiB1CxAfYDikxTG7+FifmcxKcUHNqV9Tojp5f0XNhKMUGP6sr6owfU89bHE
 ANvCvp8b0qKb5BWj6a/u8vu9DeT/RfzBOAyTuqKcQbCKVBmJ1fFm9sBswtzKVit6FvxHciOXddT
 oJBgVQLFRZfLbC4Kgp2YjAUSD5fOz791TXyI/yP9Kre0ycDKrI4CBpTVe+gaPdcKovhm2L4uYwi
 TRvYaeazQqnT/wBal6TjgyoqvdfpYxn7unXERJlNJSDcKJd6XzCpMr38voGO/vTjwV6epW7n6Rr
 zxNhp+WaZUfnaUOh2bR1kspy0K7yhS5r0SRrrOX27cFjjOXtAxYQyMWG0HTbMU2aHs/Y8i1eWLe
 eKu58BymQHE52dF7ezSkN53l8iOR1n+DwzALS1G91SkpMZp+Hf07ha90cQWj28gNrF1Jjf8QPJ8
 KF95wAgfKT3mIf+OokPgqRTpihOzG8/dADhl7YejKsswQ=
X-Received: by 2002:a05:6a20:96d1:b0:3e1:9220:9d10 with SMTP id
 adf61e73a8af0-40283cbd00emr6338426637.35.1795453900313; 
 Mon, 23 Nov 2026 09:11:40 -0800 (PST)
X-Received: by 2002:a05:6a20:96d1:b0:3e1:9220:9d10 with SMTP id
 adf61e73a8af0-40283cbd00emr6338396637.35.1795453899835; 
 Mon, 23 Nov 2026 09:11:39 -0800 (PST)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8c873b25bfasm5952948b3a.46.2026.11.23.09.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 09:11:39 -0800 (PST)
Message-ID: <423e551e-cfc5-44a8-8061-2dd454248a42@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 09:11:38 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] tests/functional: misc fixes to functional test
 suite
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, qemu-s390x@nongnu.org, qemu-arm@nongnu.org,
 Christian Borntraeger <borntraeger@linux.ibm.com>, qemu-ppc@nongnu.org,
 Thomas Huth <th.huth+qemu@posteo.eu>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Eric Farman <farman@linux.ibm.com>
References: <20261120121458.3723625-1-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261120121458.3723625-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: oRNcHN9X900QHANxlm-mSR-hpHxtfUt-
X-Authority-Analysis: v=2.4 cv=K+O3jCWI c=1 sm=1 tr=0 ts=6b0473cd cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=c0_jobgDb0B2UsOWms8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfXz2ngzkz8zyMB
 gep6OwZboqEb6jmeP0IP6iKQDTci57EVioHqKAscbaJcSxP2JQ2am8907o7hS1mELG0gWT32kI0
 xY9yVitonpLfXpRaU3KcowzTCY37b6s=
X-Proofpoint-ORIG-GUID: oRNcHN9X900QHANxlm-mSR-hpHxtfUt-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA2OCBTYWx0ZWRfXwxtiEMoEkeqq
 tQAywA3keeiW0oXh/EngA3isAY1hW1J2oLjehGJbVO/d4KEv6Xw4qc5NjS1KBvSfx0I/fCtP9tC
 wM7TPr546Mwnxlha0MMMgagf4K58PrNk7iXXCwp/sm1KShPyAg4oFYK4oxC4lvhywqwG4XO3xAB
 aQaEV13ie3jj0Cllnb1gHC6/MS2KyBRFrkn9KDkOZsJLRpCCBuJApIfaw9n/31Xk1/VwV+hMCaj
 3aujyAJu+dTooFb2PqL51nc30pPiWXrIKc2J5nG/4pGfqjCfjkFTqr2UeHqc48HWRfh/cDNW+Pl
 MuJl73Kk7A53me2UCZNzUDWG3AuTj9HofsacI5bdMVg6GD3aW/Et8IMMFHIs7H//DbUiGgXwc+f
 iZonAe3+ZntC1QRZcOdXv4V3JyJtQVAJ9pXnF3+bYULUqF8YnuV1s4P4VD6XMAZJ4rQkxgPyNGl
 E/CuRcebKlYKK/75jPg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611230068
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/20/2026 4:14 AM, Daniel P. Berrangé wrote:
> The first 4 patches fix failures to download a number of assets
> whose URLs have been deleted, or moved, content regenerated, or
> put behind anubis.
> 
> They will need to go to the pending 11.2 release and stable branches
> too.
> 
> The remaining patches are bug fixes except for the very last
> patch. Those can likely all wait until 12.0, but cherry-picking
> some of them into stable would be reasonable if desired.
> 
> After this series is applied we have one unresolvable problem
> with assets for MIPS, the yamon-bin-02.22.zip file hosted on
> AWS is throwing an error about using the wrong endpoint, but
> I can't figure out what the right one is (if any).
> 
> Daniel P. Berrangé (12):
>   tests/functional: update to newer sunxi kernel package
>   tests/functional: update sha digests for tuxrun kernels
>   tests/functional: update URL to rs6000 firmware
>   tests/functional: add Accept header when downloading assets
>   tests/functional: check if we are served an Anubis challenge
>   tests/functional: don't write timestamp unless successful
>   tests/functional: delete tmp file on interrupt
>   tests/functional: honour make jobs in precache
>   tests/functional: don't display stack trace on download fail
>   tests/functional: always raise AssetError when download fails
>   tests/functional: only run pre-cache once per class
>   tests/functional: optionally display download progress
> 
>  docs/devel/testing/functional.rst       |  6 ++
>  tests/Makefile.include                  |  2 +-
>  tests/functional/aarch64/test_tuxrun.py |  4 +-
>  tests/functional/arm/test_bpim2u.py     | 19 +++---
>  tests/functional/arm/test_cubieboard.py | 15 ++---
>  tests/functional/arm/test_orangepi.py   | 19 +++---
>  tests/functional/arm/test_replay.py     | 12 ++--
>  tests/functional/ppc/test_40p.py        |  3 +-
>  tests/functional/qemu_test/asset.py     | 83 ++++++++++++++++++++-----
>  tests/functional/qemu_test/testcase.py  |  8 ++-
>  tests/functional/s390x/test_tuxrun.py   |  4 +-
>  tests/functional/x86_64/test_tuxrun.py  |  4 +-
>  12 files changed, 123 insertions(+), 56 deletions(-)
> 

For the whole series,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Regards,
Pierrick

