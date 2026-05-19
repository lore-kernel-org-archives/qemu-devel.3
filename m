Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEE5CD4F5B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 14:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPLEq-0004w4-FY; Tue, 19 May 2026 10:16:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLEQ-0004l0-6f
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:15:38 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wPLEL-0001Kf-1q
 for qemu-devel@nongnu.org; Tue, 19 May 2026 10:15:36 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64J9LpvO4062972
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:15:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zq45Uk6GDEQaLXBxu1cOyDlzDe7iN7t/2rfODEJa+jw=; b=WmIrmcyJ+kTGU4HS
 Q5K6KvpMpwDeuxpt4CCNQjHG5WvH0SQ9TbVW7R89EMXHJ5RgfS5f6DX9sUImi8p6
 Izw5OIXLjHhkFrrTdeAMO040RDk6xxx3ukPwryMNicg6GC+YSJjVZe8ksEX2vCHR
 9L++RqN6jCbHEY3rvZ+H9z5gLYmOWIN9K8n3LHlUIQs+WEMXHShxSexBuI9Z6QF5
 8h7AePp/5eNxzO+4ennspxd3HTRMJy59AwD8NA+UyuxQ9KmpOz+rwVIZ54ymbMlv
 T95C3cNSdU4zpkm8B7qv586E3GFk8H+imEYBhmDdSrVNKTUGHpeRWmsOLbXyo58l
 QGzDtw==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e8n5u14su-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 14:15:30 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-135f2aa4742so305575c88.1
 for <qemu-devel@nongnu.org>; Tue, 19 May 2026 07:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779200130; x=1779804930; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zq45Uk6GDEQaLXBxu1cOyDlzDe7iN7t/2rfODEJa+jw=;
 b=TcGvBCFoG07gkeBN9AekHr5XsTez4Xal7M0ByNyMgMrSvoID/Lppv4YaWgMOt2eGu0
 52opRtd67s8H3463sJBQtqzMY27wr1cwKj+qbA/SpueTH6XMICt4L56hLbuKMQKb8Ye3
 Lb14JM/vUCqvW7hSob4SzHRkA+Ho6dVH4MG/Q3AcoX3y33/dQn+/gG6AaHoVq5lPCuI7
 1aBejcQNmD9qU/pBKkN2jA+Uutpnsz4QiCvUo5Gnue+NLnOqZ60uFytj3D6pNsfEkPk7
 y6z00BN+6kKb/x0kVKdaYmxFA8u+UdJxqgk7HGjhXSN4IPBr7NN5KCfRvBVaYavSwHY/
 Fo0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779200130; x=1779804930;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zq45Uk6GDEQaLXBxu1cOyDlzDe7iN7t/2rfODEJa+jw=;
 b=PW5iotR7dr6oP6NTUzXIa3hZfx0/zvvV4dNIspawoiEEigHyscfPgiTIMNI9gc1QxF
 3K1v5YpxmFpkvaG7a0tJ6bgPxQ4sLQzG54Pw4x+bTA3EBEBFcHxGxmzEgN9mkR07ZiQD
 Nz9rYtjWm40zDoF99kW9SpUv5fkOHYZ02jwM772FIEzAkHwKcwRfSDZLdDcjgB/GGVOd
 6XOekK2Rd2OIbo4rqwwUmwOTQ3w2uZEwZnJLAYdh1v//MZND67A/Nf92PYE6mIHcXRpw
 wdaZjw6u5dFNuxTQcw1KbuNf3BeXKwM3Rk+oVfUoLl9+cNYz63qoegISfH4of5fLe25N
 0gZQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+4gL12HbxhkZvFFUIACzoe5wCiezdKkS+S1cq09z6h0ljuSxHr+mtcH6GodpQgJdtiEgOg2tLXEnLD@nongnu.org
X-Gm-Message-State: AOJu0YxviAoZbCsGeJoDkXgs/hDeM9gnf0WeN8mhgDseTUdgOLjc29O7
 nJ+DsuVIc1ktt6uU8U4vtZv5+3zH5SXuRj2/kGPaEhg6o+XZKsdv32Eb0OGWfp1HEJsOlI0B6Y3
 uxaOIbTRvyudgwExA5wn8dx9tYd9FXpn1+AzuySbEAoNJPIvFS6QILNa/Xw==
X-Gm-Gg: Acq92OFs2b4WOQFOi3PHT0dfIkVqQ9YjPKPYvYz7uniaseLt5mvI1VQZJIUJE0d3Aa3
 h5MwayegFbSHK11r4O4XLMhlwTDmnX8bQSd9X4dg8gCUuiSVACouhO2Oz9mZrBDI3oIL8DanIL5
 B72nGXW0YCbVIe8cCxtyUzMHcufagUrPJgKVqJJlGfszWR/rnbWaeg11Tphv4xmCO5DHVtJ1l5j
 FYX9IxWYmCumHzrcIgDDAW8VpqaXlWepuXZ1eCCRk0/Qh1iilormsTBiHvQdJaIw/c7fclsTcSF
 0CnpiPgd7RgA6pAeyJ2MnCLcQurqUHzREUS6ScUrfm5Iv9KvSYn4Ni8WaGjN67jdbtvxhh7E25n
 0waTMZFnW3zcuSA/T9w+xWFIgRlxYIGjGizsLZM0KrP7Ge90YuDp1hhg=
X-Received: by 2002:a05:7022:2397:b0:12d:ed19:e6c6 with SMTP id
 a92af1059eb24-135048413a7mr8692260c88.31.1779200129593; 
 Tue, 19 May 2026 07:15:29 -0700 (PDT)
X-Received: by 2002:a05:7022:2397:b0:12d:ed19:e6c6 with SMTP id
 a92af1059eb24-135048413a7mr8692226c88.31.1779200128968; 
 Tue, 19 May 2026 07:15:28 -0700 (PDT)
Received: from [10.36.20.156] ([24.52.49.135])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cc2352f2sm23121803c88.10.2026.05.19.07.15.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2026 07:15:28 -0700 (PDT)
Message-ID: <fb777d34-9ec0-43a1-b70e-f419cd5b6200@oss.qualcomm.com>
Date: Tue, 19 May 2026 09:15:26 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 11/16] iotests: use 'driver' as collective term for
 either format or protocol
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Kevin Wolf
 <kwolf@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Hanna Reitz <hreitz@redhat.com>
References: <20260518160051.903616-1-berrange@redhat.com>
 <20260518160051.903616-12-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260518160051.903616-12-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=MfBcfZ/f c=1 sm=1 tr=0 ts=6a0c7082 cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=bunxBM7YXCFQTret8gAQLQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=mh9BgtYi7N3tmp3PxsIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-GUID: KUt-8AQkDpIpMCrIIHkl1eZWbz59T6Jl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE5MDE0MSBTYWx0ZWRfX5EiiVT7FqsrA
 WlqWux/v27NObf5SBOsoFWG00Az0zelwJopiwjldmItQlLJet9gCAxCs3fVVpO0NOeyJ5fhVCmX
 bJrEB4ZfOQz/OmqW9bmrMj3U5Tc/astTMaWcHj2/ZZ5QDVh2kH2q9ZAN+UWFE1XsbaEJRAUsUZj
 B1foWrNsY0fVxbJKCJdJsItysCKwkTCoTWVnH0/GjIw182Gx9Z4ZW9XXkzjctwXeZMIEB2+WZ11
 fE+5Gql4xwLCRYe8/HD6DTN/HSFdXZ9MxjvyyxCjrx524zbX4YifrOJkApz8wAKA/EaCOnAoFtJ
 5DgVaSYW3vHtlk3Scw/jLga7e3Y/RewBCdD9ZBH1SXYwFUOzi4H343ve1yJJnjoG1plmvmD3zhQ
 7thghxYfFYoaeMtHZ2IQxCSihQJj5YRMe/MW50T8o+1gPjekFsfkGxACcNTd72b1l55ajyFTUu6
 aDqF1ybVGWCidvpDawQ==
X-Proofpoint-ORIG-GUID: KUt-8AQkDpIpMCrIIHkl1eZWbz59T6Jl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-19_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501 suspectscore=0
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
> The I/O tests integration previously exclusively tested block formats
> and now also covers the NBD protocol. Replace references to 'format'
> with 'driver', as a generic term to collectively apply to either a
> format or protocol.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>  docs/devel/testing/main.rst    | 13 +++++++------
>  tests/Makefile.include         |  4 ++--
>  tests/qemu-iotests/meson.build | 24 ++++++++++++------------
>  3 files changed, 21 insertions(+), 20 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

