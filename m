Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06629CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 09:09:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENbu-0001cQ-UQ; Wed, 07 Oct 2026 05:06:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEMIO-00059p-6g
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:42:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xEMIJ-0001CG-NC
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 03:42:34 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974lMAe3929609
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 07:42:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 l9WdBXeod6dOL8RUzzjV6WpAT8ugvrZFRM8YoRy27qI=; b=MDYSiyJ8G40MZU+V
 /E5jKWaKxDTRIV+HDdERgi8sofVn1zueeeYb9PPRB/IyZEnQ6hvKPMHj3tSwrKjQ
 6By+Utfyz04eWMKpSDY7/neQUgN/mLWmQqeJEd7Vrj6gy2nBrm5GS6hAa0Pc/tTg
 qNCAxaLt0T/b/3/vta4DCtW5diKqdURKtdkHmFw1lWXkttpW+brcxjWSVRIM9C+J
 80SN/tDz3ESHFVNBomfuBbz5MfpI1iuHVoRLXC6djq5/RSvPRVz5foyizvm+rVIb
 INVLCjo9GNtO5mkMIl1wjRFBrhMaLBe+ZJY2RW4mbSsICVLHt95XLDzPIyrZiHY1
 ovap8Q==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5fc58fsv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 07:42:29 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93e46c120dfso392602485a.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 00:42:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791358948; x=1791963748; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l9WdBXeod6dOL8RUzzjV6WpAT8ugvrZFRM8YoRy27qI=;
 b=FZQ145PtJ8MOci013kXuL2c63j6qvyG3qVOeAVn42jWiZjZPbiJSswYe2xgnucykZg
 eUSQ2z3cQCV521w8oZZ7NiFk8AZuA8q+0lDGDbbSWdHRLwL9rhua0h221H7kgq8gIHpU
 Qm+l6FC2XS51oX9z5rSyliHd1Dp1O4654+ur4pbs3L5ucZTwl7YInMcOxOqWngnt21Yp
 jUT9e7sHO2z57A3A3QE+NB5ciH2Wwmk8VfrjW3iVO3ERX2LFHckket+2MKeW79Y4WCVe
 nHYK9AIoZ1ZNbN4YMKIbY1KIwrES2BKE2PNDMJOhoFeR4/NdjKoNSOUBiR4ghD0f5z+X
 TuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791358948; x=1791963748;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l9WdBXeod6dOL8RUzzjV6WpAT8ugvrZFRM8YoRy27qI=;
 b=HXrPaQIQuxStPOGBmIqfHu/RDyO2eh+NwJDU0Wi6xXeOPbP3M0fXv3jP+Gh7OvleYT
 8aJw965oXyO3+DxOFTdAa8vyJ+yTvQtYo0DRA7X+4+laP9j5x0kJEPoy5hLIrGjZkCSc
 vqxv7x9UmmQ5J+gYb3NSv4My7Q1w2KshXhIOKHhbqgSx47zUZAynJTSCvyTQO7YyxtKz
 vtkYw7OCprWniH82M+64V6LmZllVh2xdYna77vzu677f/SB8NqNiEnW7Lph9NU60dqpi
 93BJy3wdW6frjVP0R+KHXMSunoAa0LBHk3MglJLYv75r+EwDO6HQg3KvdgQqJx/GfoaC
 eRjQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwaJ7xNTthmTe+wN2f8aBl5Y4QP/CcdryzJREWmJJn4O0A8u8hQk8gYqwSzukfWQxu/Ka484XIhw+lo@nongnu.org
X-Gm-Message-State: AFuF++kwXcERuxweLe7hCOTLUmtBDUy0aSOlwZzHcQmM0G9YrjnT/r4Z
 UqiIzi7TqHrMQDHIVZoxfLAR85/qsIk2/jxpu9WSk6IgJFnFDIHPmglwUV/Qpfk1qduKF1HS1D1
 pMaKP1qsuHd/vT5ZSd2E0VWYr4uc1TuQvfgmhskUES5QXKpC06GGHsdKFWA==
X-Gm-Gg: AYBFou3VEustTdrVgJpU4WE3NE6h0rt+CTW7TVSt/I9MZHlFSe9yOAUezwsTGWdFFMT
 JArngqUjfxJjt9So8x3hO+/YyA/yWfjN5Ch/J1DNbQouIkj3tAqpd+CCTldB7uDFp21QKt4fQo+
 v5EeZ4OoiHFrgsmApeFWw4pVKnWz+dbPyxCCbuqiodlvnZWQsp//3R+bhqsPBd1Gnx9QoichYpf
 g5fQj1L9zOe8HOl9kWlE8r88UjRdO2ENg5x/ajfHDW5Z03bmpnKo78THirKTJUqeJg8kqqvMM3z
 sGZ7IlXl/gRkAivWoKXGstJAQEDnbj3yIm9LeEXazGVorROMCGh7K2A7xaZXjTes4w62+1+uTnG
 XEI/8bKiD44cmieQasF3dlwUB84mwBX+trQ==
X-Received: by 2002:a05:620a:4609:b0:93c:8af1:e352 with SMTP id
 af79cd13be357-93e9b81523emr292535385a.65.1791358948188; 
 Wed, 07 Oct 2026 00:42:28 -0700 (PDT)
X-Received: by 2002:a05:620a:4609:b0:93c:8af1:e352 with SMTP id
 af79cd13be357-93e9b81523emr292531785a.65.1791358947685; 
 Wed, 07 Oct 2026 00:42:27 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1794a1af9sm122348495e9.5.2026.10.07.00.42.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 00:42:26 -0700 (PDT)
Message-ID: <95c99cac-ae83-4bd2-ab09-51c2ef9f1259@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 09:42:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target-info: preserve full softmmu target identity
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: luoyonggang@gmail.com, qemu-devel@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20261004072927.1142-1-luoyonggang@gmail.com>
 <0b84bf4d-3b98-4f52-8847-9f89bef92c1e@oss.qualcomm.com>
 <CAE2XoE-joWZwrBy-jLe+=ZP7OGM9cyDrF_5hz7koVPODeys+JA@mail.gmail.com>
 <b2297f92-a685-4399-a755-bbe5a37b9b3f@oss.qualcomm.com>
 <CAE2XoE-4Pdp_n3RgpqJ5se_KTHniMAJAodTLmkfV+0jjou=M5w@mail.gmail.com>
 <c6bd8e8d-3160-46c2-ba4a-2f5a4b93cf38@oss.qualcomm.com>
 <CAE2XoE9PKNgE1Zz_frOq_DrgqrPL4B8hcq0xO6ywCNTeUnFLvA@mail.gmail.com>
 <63d20cc8-8003-489c-9f08-28369a2f71e2@oss.qualcomm.com>
 <CAE2XoE9uqEcjMsqJXu6Cr+MrposPjq7O6Lnj5cj7uW2nF38uAg@mail.gmail.com>
 <15e9a768-95bf-45aa-8175-1dbd73d5ee04@oss.qualcomm.com>
 <asT-GoQ6xH4-dLET@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <asT-GoQ6xH4-dLET@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAzMCBTYWx0ZWRfXzZ0OWnY5DIsj
 bN4x5YSqoY+Am65lAHrNGKVNyAThua2OZSzI2wpPTBepVPYfn8QL8Rkrn0mFmxtLggei+oyq/Tt
 JFLr/tq0gKpydqugUwa1GukWWeFtgCA=
X-Proofpoint-GUID: q01cKJAh3LW1_HNAE1fD1-Z78flE_Ka4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAzMCBTYWx0ZWRfX+KJk2Vgblrhx
 JvSH6jRc0jp9XYP9IseT10CbwBPJKndgcYQPZUZPbUnmmfx0n1HUYKB2WSkmFjIyebP0501e6YO
 +4a868oI8nURYOEu1gk21kIRj1UpPEPvggBpfwLW+bQ9hJreOFvGu/RbQEDw/ZMq0ZSQyjqO3ID
 Cf3fUahlMMyukJp77YjrNXnsG+RcmGvcyhJftbNrVnlcZCLR4DJLYn6y0n1fozBlYSu8O4B2Wig
 8DlIc8zUY3ZYaxgEQXMYWiTVI4DKuKLAOoMpoR9k3luXRUzRWJ08dPpgpKy61fhBpCzSF3/7bSR
 k0X1+5sKg2AkrttkWs0QFL68Cpq+VNejeFiwewRdef7bTtrCbZvkWo4Ft8obgDF5VlZVp70YWP9
 Q7ocer9CTugPhlT/BFkHVYPj+2GFqiTTBQ3IVCpLmD257UhPt4zzQgNUJn9Lnou+c7hROGWzxVX
 oOYvAbPniHqj4AkOPuw==
X-Proofpoint-ORIG-GUID: q01cKJAh3LW1_HNAE1fD1-Z78flE_Ka4
X-Authority-Analysis: v=2.4 cv=a6+lZkSF c=1 sm=1 tr=0 ts=6ac5f7e5 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=BmqE10pzgC5YusNNZ6wA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 clxscore=1015 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610070030
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 6/10/26 15:56, Daniel P. Berrangé wrote:

> Current git master is exhibiting a regression compared to previous
> releases.
> 
> For example on 10.1.0:
> 
> $ for i in /usr/bin/qemu-system-* ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done

> /usr/bin/qemu-system-xtensa: "xtensa"
> /usr/bin/qemu-system-xtensaeb: "xtensaeb"
> 
> 
> but on git master:
> 
> $ for i in $(find ./build -type f -name 'qemu-system-*') ; do echo -n "$i: " ; echo -e '{"execute":"qmp_capabilities"}\r\n{"execute":"query-target"}\r\n{"execute":"quit"}\r\n' | $i -qmp stdio -display none -M none | jq .return.arch | grep -v null ; done


> ./build/qemu-system-xtensa: "xtensa"
> ./build/qemu-system-xtensaeb: "xtensa"

> so we need to fix that behaviour change for query-target.
On a side note it would be helpful to have such test in CI :)

