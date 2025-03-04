Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FCDC021B8
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Mar 2025 13:13:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpS4d-0004Gw-Cl; Tue, 04 Mar 2025 08:12:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpS4T-0004Fz-So
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:12:31 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1tpS4R-00063y-3F
 for qemu-devel@nongnu.org; Tue, 04 Mar 2025 08:12:28 -0500
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5249sVkD006039
 for <qemu-devel@nongnu.org>; Tue, 4 Mar 2025 13:12:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 HhSnLddRXFGQwLIsJg6auJ0xezINDoLPFSjTA2WDCAA=; b=T5bNXDZxh1tVeqU+
 0T911jYF31bVYIiE+v+pH4ONJYEeDEMXgOmbJXbxST+zbk93LFeqXp5lU6UTDa3P
 1+NRzoNQRNUT1TFOOgALPDDYZb0wbpXTprQ/py9GCstS/hhHJ/eD4UDjnPJZWaHM
 AmzbL2Pr1JRXYp5qjQ/bqX6EXvtcgMQcOkoTv30w1eayTnnkFXKESfY3K7LAzeq6
 YAPQB+XL13/6lnFCemdW40uwRG1Rm2USXWv48gocCvff4qhx6Hy/ooZ3red5OfRb
 rWH316YOVadUNIHYqyZgMaVfu2TdGBlNuObDYdksmQxle8vTAd6sTz/lyVzB7Vk6
 puwlrA==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 455p6thwrh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 13:12:25 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-474e712ef4cso35610131cf.3
 for <qemu-devel@nongnu.org>; Tue, 04 Mar 2025 05:12:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741093944; x=1741698744;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HhSnLddRXFGQwLIsJg6auJ0xezINDoLPFSjTA2WDCAA=;
 b=EMWOB6jsYdV3YNbs4yytrPdH9+3dLGGh4PsD/4YmBkTF2y4molJ/ZU5il8ow7/h1fA
 UrKPPqVviAgob1s+gDjurpExI8y/GxjCKCTlQWGn+b4WnxaucJQrJPxM3xYSuh7pVQYQ
 Y/+6c8l9yfS46AGRLnvPNSVAu4eSCPH89L8Jo2f48jyXVL6NdL4mzwLfdAYb+yXGDleq
 TgvKuy5YPG8hiU4iYAYyTF9TPOuS8e8D/Lj8dRaoP8C6O/cpyeYA8WhZ+xikbx55Ks5N
 7WgTP8vA/tiyRhy/3/Tp0FjD4tSeJhggDUy4ZWbnMEodxFPDU/YWaoiVKL08TNrADLpd
 HMWA==
X-Gm-Message-State: AOJu0YzfD7a+VxjEMQBn75cEgNdYboIiCMwMCR/cRn/iDaPBfz0B/RuF
 OBZiVg5gbLAlyoeDjc61aIqBPYVdOyeKkT/iEUxBOVBpveyNjSbIzD7O1Nz0qiJggVvzmVi+u8T
 LQVRts4XqVzUrhA+rVWcdZ9lDkv9YADZiWZ2vxQDanVok/Zgp/20tDZTsWUXBWw==
X-Gm-Gg: ASbGncuAYISwKBQcrzv8QOq/p5SlZU/8kPcRpdh+Qlh8a8WYPbqpuhFPvjhmkTBUO4g
 fLFkhxgT2p2wRJ74FyvqXChjJQbwtPAwtGlb8M4MsJlhV2GhPVHWKepVDVugk7sHcnTB1LDuGxw
 0to46WKR2g6mcA9krb9Ysk5F6PY5eVnK3Uy+5Wa/3yV/y0uiUILSn5Vsq3Ju8r5589/SUUsoZJv
 RtoxzyH1kgO5FXSUaQ6iymzyjDPuOgRJwx0sV3KHU1aHA2I7Po/G0yaIMQOCRF9y7nOt0/y1yKI
 96ZXYS7zl372bdk4Y8mnKVvv9kxBRavwOysF8ssM5cqBBX++l4m9Sm4aRkQgCZeJ1OKNlnR3DAG
 iA628XtBOY1ecIoog
X-Received: by 2002:a05:622a:1aa2:b0:471:fc74:100e with SMTP id
 d75a77b69052e-474bc0a245fmr250300101cf.28.1741093944180; 
 Tue, 04 Mar 2025 05:12:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3G2HPETqU8wU4c55IKfNYVkf3R7ROUadMJfJl3+ftX48VlznGvaat3rDriEcT7ht6HyK1gw==
X-Received: by 2002:a05:622a:1aa2:b0:471:fc74:100e with SMTP id
 d75a77b69052e-474bc0a245fmr250299631cf.28.1741093943709; 
 Tue, 04 Mar 2025 05:12:23 -0800 (PST)
Received: from [192.168.1.157] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-475083eabcdsm841891cf.13.2025.03.04.05.12.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 05:12:23 -0800 (PST)
Message-ID: <9707867e-5357-4307-ac5f-394365cc1bd0@oss.qualcomm.com>
Date: Tue, 4 Mar 2025 07:12:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] hw/hexagon: Add machine configs for sysemu
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, richard.henderson@linaro.org, philmd@linaro.org,
 quic_mathbern@quicinc.com, ale@rev.ng, anjo@rev.ng,
 quic_mliebel@quicinc.com, ltaylorsimpson@gmail.com,
 alex.bennee@linaro.org, quic_mburton@quicinc.com, sidneym@quicinc.com,
 Brian Cain <bcain@quicinc.com>, Mike Lambert <mlambert@quicinc.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Blake <eblake@redhat.com>
References: <20250301172045.1295412-1-brian.cain@oss.qualcomm.com>
 <20250301172045.1295412-3-brian.cain@oss.qualcomm.com>
 <87frjtz4wj.fsf@pond.sub.org>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <87frjtz4wj.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=HZbuTjE8 c=1 sm=1 tr=0 ts=67c6fc39 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=Vs1iUdzkB0EA:10 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8
 a=20KFwNOVAAAA:8 a=II-lAcbK-KrACQ1VvH4A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=kacYvNCVWA4VmyqE58fU:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: Z5ieiMMyhMwKdR6iUSRltiEAreOyDZeY
X-Proofpoint-ORIG-GUID: Z5ieiMMyhMwKdR6iUSRltiEAreOyDZeY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-04_05,2025-03-03_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 adultscore=0 mlxscore=0 spamscore=0 clxscore=1015 phishscore=0 bulkscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 classifier=spam authscore=0 adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2503040108
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 3/4/2025 12:27 AM, Markus Armbruster wrote:
> Brian Cain <brian.cain@oss.qualcomm.com> writes:
>
>> From: Brian Cain <bcain@quicinc.com>
>>
>> Co-authored-by: Mike Lambert <mlambert@quicinc.com>
>> Co-authored-by: Sid Manning <sidneym@quicinc.com>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> [...]
>
>> diff --git a/qapi/machine.json b/qapi/machine.json
>> index a6b8795b09..a7070bad4d 100644
>> --- a/qapi/machine.json
>> +++ b/qapi/machine.json
>> @@ -33,7 +33,7 @@
>
>
>     ##
>     # @SysEmuTarget:
>     #
>     # The comprehensive enumeration of QEMU system emulation ("softmmu")
>     # targets.  Run "./configure --help" in the project root directory,
>     # and look for the \*-softmmu targets near the "--target-list" option.
>     # The individual target constants are not documented here, for the
>     # time being.
>     #
>     # @rx: since 5.0
>     #
>     # @avr: since 5.1
>     #
>     # @loongarch64: since 7.1
>     #
>
> Please add a line "@hexagon: since 10.0".
I don't think it will make the cutoff for 10.0.  But ok, whichever one 
it's bound for.  Thanks for catching it, the next revision will include 
this fix.
>     # .. note:: The resulting QMP strings can be appended to the
>     #    "qemu-system-" prefix to produce the corresponding QEMU
>     #    executable name.  This is true even for "qemu-system-x86_64".
>     #
>>   # Since: 3.0
>>   ##
>>   { 'enum' : 'SysEmuTarget',
>> -  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hppa', 'i386',
>> +  'data' : [ 'aarch64', 'alpha', 'arm', 'avr', 'hexagon', 'hppa', 'i386',
>>                'loongarch64', 'm68k', 'microblaze', 'microblazeel', 'mips', 'mips64',
>>                'mips64el', 'mipsel', 'or1k', 'ppc',
>>                'ppc64', 'riscv32', 'riscv64', 'rx', 's390x', 'sh4',
> [...]
>
> With that doc fix
> Acked-by: Markus Armbruster <armbru@redhat.com>
>

