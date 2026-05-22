Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2AFCD5BB0
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2026 17:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wQU1m-0004U7-3h; Fri, 22 May 2026 13:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU1j-0004TN-Vl
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:51:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wQU1i-0006tM-2o
 for qemu-devel@nongnu.org; Fri, 22 May 2026 13:51:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64MCD2Z81958709
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 B6XtmqdU0ZnakdbJzlIeNZ46Ug0URjVcqmhHgjk+JYo=; b=eBk/0IbSrKWvY4zV
 HBW6ho0cpHpvh3bxRc0Y/Qr1JCMgBKGivWWqf/NcXg6NwTQwRWHRNXim2kCwiri1
 ASMn7q0KTiEKjFUX3MDaLdhxrfGUVERLmZmOScghJKY+CQZSRC3H8ZZ8jtevw1uR
 rzWhfbhfDTSnLZtu9cVXmA2UaL4o47onNWYib6LXJ/B9XBKOldesHR4CkK4C7oLT
 HSUlL+sQcq7uZkg5ztmI7Qhja6if4uw8S3fi75ulbB3n37a+CE6LYd92TUuwtH53
 I9bC9mPXoQgMAovCYzADehK1nB4W3Y01XDyP+iZzLVVUhW1Gd04ZZsBJC8usDVDe
 TM9jDg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eahxetqs0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 17:51:11 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-2ee34588671so8621766eec.0
 for <qemu-devel@nongnu.org>; Fri, 22 May 2026 10:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1779472271; x=1780077071; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B6XtmqdU0ZnakdbJzlIeNZ46Ug0URjVcqmhHgjk+JYo=;
 b=XLvB+sIZ3x3aVrgyhYJ5pUP3ThE7Eag2w+48QRegObwnl6rCOXeA6HaX1pq3oS3Ch5
 Z4SJOhZiDVtxmYzlcKRpU+WT75Ag0r4IrhlRsceztV/PwlqlBb1vVzwG7a2c1wh+69Lx
 SVN1zBGUQOssydknYLPV3um7WKPx4z7oQ/htyovK5wgZ/PkF+sG/bkmdaP0BBGaL/Gvx
 hfxf7z8nGeaHiFNbUKZBeI3jNlqDIYl0b0wx2mn0PdF6vgdvPHleMdVxsOASxaQN4xmf
 Qeg1tPBkLtFzdDtpGKnhEkigAEj3o82wr6j2rf7K+yRmYup34qng8OqDMIOCNSei4SRl
 edQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779472271; x=1780077071;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B6XtmqdU0ZnakdbJzlIeNZ46Ug0URjVcqmhHgjk+JYo=;
 b=E/P1WoONGDk9+DjBaM4z+AmjpD1Hs1c7e+qcbBcu/1YfPSzn942bdF3gPQKhpJ1W5i
 +MEU8T/a9LhAN736HyOEhsarv9pkvi8usbrBdveaEW7cKIJfKQRdUnjU1IBFkgLEUGoK
 ialSF4woTs8lOcZ27F6aNeQMWSPVkQJvKrktg3G6eBifyY36xh4sPOiZnAqmuNXwfsGi
 O+aXGXmKqfdBEgz83fexpJeDaCZTxjuyzFxHWy1SrE+4U9VsX1DKJzpdeKzSFj5yyfct
 zYvRamw5DhCQYNde092FIQxuhG3aUSOMNS8s0QAy8XZp/jpgDy6fluXC77xel8mSk1dT
 8ARQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8PMDjWhRAL5pHISX++r64ukde16zAzULGRuPb2khZXeJjCIfZp9hQvfdJHVyDnKh4T+Y0nhcTYvQL4@nongnu.org
X-Gm-Message-State: AOJu0YwoTDuGsnnRYdDOUO+2gGCPXez3S5RXc4oXbBpq568pcalROGYm
 pnP4+32yqFfGQ6AKLW9Ifr4JaJxLRgW+jdnR602c6s7F/4onOfCq8y8/gxIo5JfJ4eiGMo43FlV
 Pol9gbgcOQcET3bRXBrEyIKUqHZeRZKM8yWVdZwhAiw4/hnYsttcP3t81cQ==
X-Gm-Gg: Acq92OH0AlYPPplo1s/erK80B8kXFj+qkuZ73lV+oCnBrRuyNrHj7FoKLVbiypTM4fM
 3kKn1VAPqkWxs36rel+WTDkMYlAnoRf8qQTsjOXUBpMKLjAZxrb29OfXv+0Xv4wnrlPc35Aprh0
 o70XD7Ugy8/3fBvdn/1uhPLIyIMNS8dBGw/fkVz4NwIXVtlh2k1OpvBGTPH6xZKJe7onSeJFsp4
 jVbsXKWxyUMBbvW4UbLVgqSDgMS8ryUckd3Hro1dnvsIjq4hNOQd6y2iNnf6lvLo8mgqpKXhSsf
 B7tVGHw+NddN16+PYMLIo6dLuUM1b+CbAe5GlF7W2kn86ON4BhWcjoA4RlH5oZjkF/TwAo9A4Wr
 2/dEhrz6ZJsJOTq6B11nSxTMATFdg11Bh3OBuUa5/lz6iie+S9NOgkGynxdyGQEMfjEWscA1EXY
 uSdPsXiTEGdW6GNg==
X-Received: by 2002:a05:7300:e8ae:b0:2e2:9c65:ef6c with SMTP id
 5a478bee46e88-30448fd620fmr2259626eec.4.1779472270779; 
 Fri, 22 May 2026 10:51:10 -0700 (PDT)
X-Received: by 2002:a05:7300:e8ae:b0:2e2:9c65:ef6c with SMTP id
 5a478bee46e88-30448fd620fmr2259605eec.4.1779472270206; 
 Fri, 22 May 2026 10:51:10 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f20ddbsm1467675eec.11.2026.05.22.10.51.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 22 May 2026 10:51:09 -0700 (PDT)
Message-ID: <f6b1ab68-8d21-4224-896b-dda140f89907@oss.qualcomm.com>
Date: Fri, 22 May 2026 10:51:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/16] tests/Makefile.include: fix typo in comment
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Song Gao <gaosong@loongson.cn>,
 John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kyle Evans <kevans@freebsd.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Warner Losh <imp@bsdimp.com>,
 Brad Smith <brad@comstyle.com>, Thomas Huth <thuth@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org
References: <20260521131739.540157-1-alex.bennee@linaro.org>
 <20260521131739.540157-3-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260521131739.540157-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NyBTYWx0ZWRfX0CPr0oQPGUbr
 QFFPUbkcqNNY8Ne528nWkH6Kd1DUqBB8YYuLvvogmn4BX3BsC4ugidM0sE4+x6gXeoK/uD8rPpf
 esUJyn6OvoxUwHTyZaL9an+5dHq8axrdResI9Ale2P4rJWruc94pPUxGQp9Tis0ODCWtMvy/SEa
 0gmcmXQO3ykv8JVDqPC33hAiqRyykep2VEM1i/Mu6tu22rV2akyr/vTkfJZ1qYOwyb+OAkYYwFD
 /vanYIrDTeivGmMAvAS2OfqHJNmJDZIrwLkHdstOrRu+VWd/RInq/fAxIuiI62MItiETBzmJ+/I
 kqH/lAtHz0zBSzmO5TBjWxSl7gb8XGnz4qCk7AccP2FVq1MKnK2OxmInsv8NTMPL3jnYbDZBs76
 SMbmOBeL8hyKe0xuObvxHvUK72OF2Z8+5KTovXm8CYmUy5T34/Pupis/5iq20b0H+HOgYpkTJEM
 5B3fnd0PSx9HvsjT8/Q==
X-Proofpoint-GUID: m7bu4V-LiuGn6DDzcTV0nEQNMkzesu1M
X-Proofpoint-ORIG-GUID: m7bu4V-LiuGn6DDzcTV0nEQNMkzesu1M
X-Authority-Analysis: v=2.4 cv=ar2CzyZV c=1 sm=1 tr=0 ts=6a10978f cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=lOGKEWSEe5e9jjuMITAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=h1q6ZXiXV6sA:10 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0 adultscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605220177
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

On 5/21/2026 6:17 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

