Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A604CDB479
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jun 2026 13:03:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcNG2-0007P9-FZ; Wed, 24 Jun 2026 09:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcNG0-0007Om-Fi
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:03:09 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wcNFy-0000pp-TX
 for qemu-devel@nongnu.org; Wed, 24 Jun 2026 09:03:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65OANXRM2869019
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 13:03:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VAwPhzEbnfqxWQxRoYfaHDBxDDx4abpcUJtWYIuWAT8=; b=MvIS31SV0hirhurZ
 y7WqUcBCLQKrgW1XhrmgEQBtysdK8phy335/pu+QqNEllvJVQqU/uCaMK2fVWIFF
 Z5n8DLdounOewwWGgy/baOcyOfZE0Ip4GnNkYrISJ1bhXA7sZybkn5eN+bxTVDfW
 fQIVHXonniLhDIzA+GSo4KAvSB/wOUvluFOoiDSY2h3oCx3Z/19twQyT8GVERCUi
 qDuE9erSGGyfSISWF9KJPMR34Oil0I5Sm6XCcWAPAEsV59FvWNaR7JDbPvgkiFqy
 Blk1JTN7Ss0IEUZ2XnEDORbLUNutBMS+3Wn6fW6nW5qpv1sU1+SZXduTohrDIsbX
 nUGHjQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0apq18nh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 13:03:04 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c890bac374eso1075661a12.1
 for <qemu-devel@nongnu.org>; Wed, 24 Jun 2026 06:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782306184; x=1782910984; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VAwPhzEbnfqxWQxRoYfaHDBxDDx4abpcUJtWYIuWAT8=;
 b=jKexZhnnQgqWfUA8M+tk9YDNrzSqLsHXbuqlhDkhFyG7wI9k+0pNOUX7d16EQUTKi7
 PgrjJ5vXb9DFaSi5ahmuW1vbNR/H+cOH9jkaUD9ePfiBopz51v4CICA6LEenjEm+9Wox
 f8uXFDeVS2b92J/L48w7uKK0HH5F5LeJg33pydCfj57MicJUsPzv+91Tkh5ylmrLok9t
 C+H72+O8Za8ef/ukYNa1igEFDZ1Saa+Jj/F3UiIWsB0IwygZccMKX9KanPJBOWOB55Yj
 7/iMZy0/tpD6ZZgmOE/Scl2bZ0LtVsvux0/qtsiPa5TnP8o0TQhCnEJYawMQSd9L+JZ9
 ryUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782306184; x=1782910984;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VAwPhzEbnfqxWQxRoYfaHDBxDDx4abpcUJtWYIuWAT8=;
 b=bxwfjL+0pdLv1UB0dx8uK5jXdvZ/0xviukmgXMNhzhX0VJxdjbCW1BfY3LGHcH4qyw
 Y0rVjv9QBXfuM/Emn0cL5PeItq3dFw8JT3xPIa7KhZLnRQPyYqY//db2kBhC3biR1cCd
 sqp0LM/N1WEfhUOHsetz71libDhhMHLdyPc/R2UwRZn0jbUdNsLKtJde6XTP9ZQbs5xH
 4o1UiOMU8DjWdGmOf6oZ7V2ouS2085WFBfN0aDCXLVk4BfWKOtfxxduwTv4eXDswY8aZ
 gIak76tlvdiWu0lsJG13QxDKrcBwXs7duM5N/YIYzU5ifkNy/2hpJaQJwJ/ispDS9FNr
 OVZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+yfjX5MAYYOnC6OwX5zRxn5SXvdAPXWtkkVhzoQuA/7CUaivq6J91+vZUx9X6Q8GgfI8WjQcDqnXPN@nongnu.org
X-Gm-Message-State: AOJu0YxKyzNA8y1p6VVxmELFTOdnapanAJr7axNewPhDtF+tbxGdRTpc
 oasgCVjguK+9KGHtM8kaX4pKjUmwcoG+SbSqTqwP3qMbuYsA6jZWNfbPAGKBy56IJbtMUH/EsYn
 Bog/12ZgdUNdKEZYgdc/sAv8KX/x/crmr6SCab2lA97O6o8dSAgnjnlgg8Q==
X-Gm-Gg: AfdE7cmSiPbCwLoUO/Ioqt4Be0ug3NSyYcfM1btGIuQv1hGeEV4uXfN8YJtDvn79T4Z
 fKEC8Lc1fOtfsL3QXGOpsJzUzx10w2FUP9pniHCrRrLIQAKchZQ/2LCtTGOYage3DibsjoKXb7R
 1HfU24iR76KyLKlhfLI/egYhaCFcxtCHar73TvQ3A/60u3eELDOt0lOznP/a7i2nZPD0z95YTh+
 ySxpDYTyLJbVozH22NnCpuTFOk5LlwNAOHtQSUbwXTLY1Syz1cAMwJ4AGguOHtVhKBmYqz39qzk
 1zF9z6wk5zy8yxS4GqIR1VbiQalzIIONuHtaIY4G0SCUeDROAxazkt0tmZ2aMuUMKl+5i3ATcix
 qoLj/USt2V5BmRPW0GPIGJFaUJs/alFmaFT6+s9gP8eU4Qe0cu32pF3R6i+n4qw==
X-Received: by 2002:a05:6a20:734a:b0:3bb:2842:ef32 with SMTP id
 adf61e73a8af0-3bd2cced379mr3864438637.0.1782306183944; 
 Wed, 24 Jun 2026 06:03:03 -0700 (PDT)
X-Received: by 2002:a05:6a20:734a:b0:3bb:2842:ef32 with SMTP id
 adf61e73a8af0-3bd2cced379mr3864335637.0.1782306183109; 
 Wed, 24 Jun 2026 06:03:03 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-697f46e0d15sm1084395a12.14.2026.06.24.06.03.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jun 2026 06:03:01 -0700 (PDT)
Message-ID: <782d666a-43ea-4692-9961-d33c2758f4c2@oss.qualcomm.com>
Date: Wed, 24 Jun 2026 15:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] gitlab: remove unused .cross_test_artifacts
 template
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260624124657.2725376-1-berrange@redhat.com>
 <20260624124657.2725376-2-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260624124657.2725376-2-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDEwNyBTYWx0ZWRfX5y6jMrIBePF+
 3pQ/IXpkFcS2hCtPlLv8yoqikfrb4Z3L9STU8ize4siHylZRadnHwMvkakyU/OpLYpYFRIJryEh
 6L+agqsNmiKBbjQq8ZRxSQmrJt/6+yI=
X-Proofpoint-GUID: nXJh6AklM3xjIrF8SXbYMVVtqT5ifjzH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDEwNyBTYWx0ZWRfX7QocCYiXDGAq
 9liD9YpqkXMFafaxG+bQvRN0kxGrvhRHFIBvIEmjSivChgHo3yokby/fMhsQ85ey9EE/2PYKgmL
 GTLwqaVmL5wPBhypHiHJavC9gY/xKj8dIbS4MZiw4VJ8+HEfNmtEA4F7LIOFh3DEkLygAOvsYij
 a3oGYk3ymSWbWL/Tmet8WRuTXOUemgNx5jo0Z0yvhCKEGDFo6x07SAKh1vwfhh9ia/Mi2eE8xq7
 U1ACa6vyABwPbnCF+JXYuFBMov6/LWW0JPv/8OXyT2C24K1Xp7whZ71V074lNpWBx+F2v0c04CI
 RLKLwzz6cqEL4krzoFiqZm9mYnERtndGihYmSVOrrMKJ2xxAU0NiWexOoe/BuwXsLTrATT9eXXb
 8tM14BavrX0leK1/5sc/BoR+pqiB1A==
X-Authority-Analysis: v=2.4 cv=NpbhtcdJ c=1 sm=1 tr=0 ts=6a3bd588 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=9y1irYOGVe-Q7SqiQz4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bFCP_H2QrGi7Okbo017w:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: nXJh6AklM3xjIrF8SXbYMVVtqT5ifjzH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 malwarescore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240107
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

On 24/6/26 14:46, Daniel P. BerrangÃ© wrote:
> This is unused since
> 
>    commit 0d1137550bbf3af7ebe34801a9bff5a4839cc34e
>    Author: Richard Henderson <richard.henderson@linaro.org>
>    Date:   Thu Dec 18 09:58:33 2025 +1100
> 
>      gitlab: Remove 32-bit host testing
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/crossbuild-template.yml | 12 ------------
>   1 file changed, 12 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

