Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBA3C5B572
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 08:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvWfJ-0001WY-9O; Sun, 16 Aug 2026 04:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWfD-0001Vp-5I
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 04:56:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvWfB-0006uc-OZ
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 04:56:18 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67G71xtG1574700
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:56:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Ptveerwsq8AQDWcSr+sbcOyMmk0ikfHRE2nusoaC52I=; b=R4C6QRHviFfY/FZT
 e9WX5J2+eBC/eEHd1oLHsDy1AUA79U4D4t4pBNgYS1VwydycE9Zx2VnPrcdJtbJn
 JG3BoHKXPMopw0M+btDk/u3nWBBOvCU5X6P9Evc6s2jNQYcVn38OO5WjJGctEw/n
 eNEN2XviqzrRJpMwYhp8vfONoB+eYoV6kbcR5UTs+nyjipz3+aSDGSxZ+zqCHx45
 CQuOK/FWbFanJE1ebhEYPmZ9+XY7sZUO8jcRZVkosWkDSyaX0En3fs1z/1/DescE
 wdOFA5+ZnoIzME8q9l3ZHSQEX0AIVICCm9j3C4jaIiJ/8wyow0dMo0z0+IUsksMg
 OWqLCQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghq3548-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 08:56:16 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-92e5e38fbc5so251680885a.2
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 01:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786870575; x=1787475375; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ptveerwsq8AQDWcSr+sbcOyMmk0ikfHRE2nusoaC52I=;
 b=XPpAuzfCw6z+iMGXQFqN1Mzz+8F8Eahgkv4TCp039wJGxuVO1hocs3v1btpXQBqBvj
 n8gPZZVzJIZdnwwHnBBphrC+OV5FiPz4M6XGKv6pk4EECN+qPCzay8F6gigc0WFwZin+
 uVOphXyQzNGzNG1D1FynxdQhUSLInJUZao7nE9f7yE07iZaZPdyuD70OcEHDGFt4whNi
 KuyBILOtArh3tDbv18vzIQ85huH0wtSa1tedpj6kv4zr4G+/obUWGCcg2bnAL16GsucH
 YZ6wkCz1VsgyN9tDvaw6Vu6WSYGJlkVqc2tUhRp56hvbcp/TwAxoIV1OpgqF80Cu9QGF
 riYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786870575; x=1787475375;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ptveerwsq8AQDWcSr+sbcOyMmk0ikfHRE2nusoaC52I=;
 b=Rn4YsvgUln+G2FxCJpBteDTBfVDhcxpQqZaUQxHsP1nQgro5U/E0YfpRN54E69KIy0
 rgJeEptiU+Em2E+9fIPJAD6DwBMYGe9hzChRqjATE9eDlRGt4qWb9bZZylufzJro2YTn
 avx+5tHFFpf1sP0Sheo7d45Rb7ftPtmGS/pFcY+GRzEU3bmB+sghONIatgZgkmrf+vIV
 1gYdJPXJOKj9jR+cY5nOXQVJW3cCtb3CnMu+FfhW7//KoRbe9vyRSJYYKrL6DlAXq4Mo
 fnU5uj1LJ3N/qWOk8ORlg51hNf8ho0/S/llTqNNqpo89Rb5AvwmpCa7S3oCYjHkN7jfJ
 5HAg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpChry1O1LB3gcMcGVCegAIduFM51iAZMwmh0r4S++Q2mvh8vQl1qACGt2om9evHmdMqZbKsl2uCjnY@nongnu.org
X-Gm-Message-State: AOJu0Yw0qAj1M206tL8kaLX3BsYX70nlWbTNgcrdpsGf7gTzqkMTSPRn
 NEw6y78HYCpIyE5lpGwe0j2RD0IG/gxRpOSXV8zQwqflxTnP+5LGUgeRfbCxxaRrKuoXt+umtWo
 GpotcwQGr5GvjDXGBqkqImqu2a2mNKz8/hNKYUyzjEHPB/8SycCkM+Z6mXw==
X-Gm-Gg: AR+sD11q1G42pdL8qY+HFE1ac+eDetmogWKHUp3EQYSfC/C6XyNvTRoHi8uoy9/tbVY
 cEssZuS+6Se/uyeBcqLW/Z9LnDuXpNwgtHXonEYb/U/wH5PHKrzV4CgwK45G6GDrMPCk7Ao1mtG
 xjGdehwAoQi7F8LG7MN5mpdNfmrywzOxeW4CRXZOaQrLPaMqUGaOCXXU/0OY7MbWpK3O4Zt5Q+x
 pJDSFkoxQxDn7EIE7ea0IVZJo1pL0FwXp3I38dxFKXC3o6I+h8UTBtI/xHnZ+6EXbD0JIKfkTWN
 sv1Fcr1Qd22gKL7sdiQ1nKmkaSFbdHEnBEPXXq2D5IEwkp9S5ByWJ9U6kr6Wh48pq2TmYiHiQ7h
 UGia3uG/s5haskG50cOXaDTaC2r3k9NQOl4g=
X-Received: by 2002:a05:620a:4492:b0:92e:7ba3:73e5 with SMTP id
 af79cd13be357-936d23baf3cmr1644553685a.42.1786870575507; 
 Sun, 16 Aug 2026 01:56:15 -0700 (PDT)
X-Received: by 2002:a05:620a:4492:b0:92e:7ba3:73e5 with SMTP id
 af79cd13be357-936d23baf3cmr1644552185a.42.1786870575036; 
 Sun, 16 Aug 2026 01:56:15 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f2cc811sm23576148f8f.33.2026.08.16.01.56.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 01:56:14 -0700 (PDT)
Message-ID: <a2b649f1-e476-4229-85c3-076d08c001e6@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 10:56:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 30/53] hw/mem/nvdimm: fix "size" property typename
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Michael Roth <michael.roth@amd.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>
References: <20260616-qom-qapi-v2-0-cc9396b9c18c@redhat.com>
 <20260616-qom-qapi-v2-30-cc9396b9c18c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260616-qom-qapi-v2-30-cc9396b9c18c@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDA2NSBTYWx0ZWRfX6I0m2LLWFJZc
 qznXuXeDj4VmuWdvNEg/xMP6o2A4HqP+5WEqEvLhnbDjO+Jval9FppO6SnnTMNqQWp0pJhT+6+G
 V9zZOfppczl1yfXlwtLcUnii9VH+miZkZLHLeoLDlRKEnWqBQwZov97YxREPhh/vbEYNB34KKA+
 EsFSHEJzpzqTf4Uha0kftq+jJAxQ098mjegFpB/nkU7WarmFBtpvuLo5jE6AU6cOBLA27AbYHVD
 KVGuwXeggJ515B4bXMNJf4pFcEkXI4SXdrkP85lNYQ5s9HU2gB5ufEtOsoiR+0ZiByV4Oc5dwwm
 3KYg9BTtJ921b5zBZ6IUsNuqhmIWpwvsRj8LGEtT/wB32QTxIApoxLMo9HF5jtjUSr1JdQWGv2E
 zjlDhJUmril/+gfcqgd2RZWnVOLVjsSIg9MKzzAbI236Fzo89dd9oixhO4rB8R6lsrtGj6DksFs
 tK0qoLAAXDvlWKWwoJA==
X-Proofpoint-ORIG-GUID: Ij2k0qss9uJR8PpnYlRbIGcHPijohZE_
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDA2NSBTYWx0ZWRfX1/S5in46lN3k
 DOXbNHXnxrKlLfy1ESXRPDBneqA3Q9z0Y2VmODKn0T+THG4xf5K/6/Po4lDAENtH1PJ05afjRrt
 nZtAZjYcjX4sP8FvcjRAEYQpsN8Ch4o=
X-Proofpoint-GUID: Ij2k0qss9uJR8PpnYlRbIGcHPijohZE_
X-Authority-Analysis: v=2.4 cv=dvHrzVg4 c=1 sm=1 tr=0 ts=6a817b30 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1k1Y3PzgwnwA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608160065
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

On 15/6/26 22:37, Marc-AndrÃ© Lureau wrote:
> The getter/setter use visit_type_size().
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/mem/nvdimm.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

