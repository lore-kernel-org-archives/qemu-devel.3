Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A3D606A325
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=li3dMQB1;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=JBnIyEQ3
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKEoF-0007CU-DC; Fri, 23 Oct 2026 08:55:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKEnk-0007Ak-6j
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:55:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xKEnh-0007DQ-J2
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 08:55:15 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAUCe2164239
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:55:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fYI4XFEx/MuM2tXwunUON5o5uCYWNUtYa5MUy7BSdQY=; b=li3dMQB1TiQFsrQK
 NkRFRyvlTpOPPgiAoeEpb1qb8Je+lB9A9f+8MX5gCdHsv5nTimRvPorQKyXLM4tq
 B2+wVeX2W/q5FJqm7LFVa5Yq7bH/s9XZhpAvdc/eABlSgU4hgIrmjgy8btu377+C
 ZIgUcA266TJL026aWVpjDtXZjDmFqfuIzhhiCkgyJLriQeQYnkGV1QYI7H22GPiv
 PUCNm2+p2vZWdPPd00oZA/yujvjn5FlVblYfztZaik/sReK8eltUo9Y459YjfWee
 i4Adx2E5D0/z978vwh0DINNQfIzT239rk5o6t1xztVGWgHShB6UzoSbhrJKYt1EL
 kCsWPg==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfpahv5vm-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 12:55:11 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-93e92aad34aso171671685a.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 05:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792760111; x=1793364911; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fYI4XFEx/MuM2tXwunUON5o5uCYWNUtYa5MUy7BSdQY=;
 b=JBnIyEQ3j14zQ/K4JTZNukayRROgyNzENtoJxuLb2RAseakYL9eaDEZA28oMqYHDpc
 rw6ze3tt+MQZxVTl+HspHZbWw7akhrWyfCr5azsLpqAqLS1QOmkJ8e9QMDb7V2+wvXuW
 c7agQtXzZvGypeJNmr7lnVyzwqIbI4nD72lKkPxUGIrFROcymJdiqMKoVJJxfgRCzS+b
 WvZO0agG3rVhaMtFhzzlY04RGLamA/4WKcs37fl63TM1zV1ti5H/ROwhbjO94AC/sPJj
 jBP+tw4BllIdhVEGl/Xh96BnbN3jQMf4Ag/O2X2IMrEbBNnc3I8D6g3xQ1a+JP9MjlDh
 reNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792760111; x=1793364911;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYI4XFEx/MuM2tXwunUON5o5uCYWNUtYa5MUy7BSdQY=;
 b=LtHr6CRQZnktRog5YARD99n0MORBJKhFU/CKbpBFmd427uHPFc+7f0g9z8ItJLeSrf
 GBB80kh+Nhwgp1OxFflUpop13Ql1zgtF4LycUR4ywJBwZBsQua0B2FLdB0v1C6zn3V3G
 AWN4p8incprx/Vnf2q9Lb9ylg27IDk2ceT2pCxp9X5/NTn5YWyIXc5a11CiBT+KsUJxI
 qmXNQ7vEwfvjpTUW73+N/nemEpvLVcxIOOZAyeAlVHeJCgv7+BMOaNWzVlMq4LK7KS1p
 qI3J0pUgzogMExiI+0FLrX+cnrBwBE7VBUKrGDxiG/RJhcjZj+Y9qUI6UWUfOBqZmeEE
 uwFQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzxV9K5Rnw7aubCEmsStrUfFcNybFuECNWDKKDCZGuY/qDYARdoGWR+0rx793BbqVORBEK4M153pHus@nongnu.org
X-Gm-Message-State: AFq9FYIH7AqK7sDGrnh0mF3bKcUeJY5smNp9lpBIbL9rb1/kR+/xrIOo
 joZ66JgwzprRIPSkeoSUkwM/7n1nNnv7M/KX2PRn6+OLDCuSomglaK0Na6OZVV1RbBaAEeFoeeI
 QVTg00noct9dpEiiRjY+a4vXPJvUEfWKh0/V1uGDJvdFW8FUYyNx8mdZKQg==
X-Gm-Gg: AYBFou2kGL8yesE2quGupfBIPBve0j0fjbg1nJum6R6CrxP+6kzaEpIXZu43/sI5w1Z
 721t2eYHesniLHMRLlUERwUUAKXUfKfrCpD32RMJAPyOudmcVGkiyAvrlsEPQiqYHWlFxqbNvln
 R5upMbY1Ce6R4F15M2RIqGL9Na7x2jmpqQq+Bj7LRD5dDJEQU7gddG0yJeKQuouDOYSuf59a5T2
 cqrFcY9wwZrukocTYX2b9LceTay5U7uhHUOXIR1fgRnPQAMp9L2NZ6P7EwOnFWTxHDEnBAFeAnO
 9KqA75XjT5bRSGmkgc9bzlToGaLMUgZC6SsdJt55uM6Qu2ze2qxJqsES87ViJ64JN10WXbVyqHq
 geK9E7IE/K83Rq+0rmBs=
X-Received: by 2002:a05:620a:6c0d:b0:93f:38c7:64e1 with SMTP id
 af79cd13be357-93f6f79b9e4mr385954185a.25.1792760110558; 
 Fri, 23 Oct 2026 05:55:10 -0700 (PDT)
X-Received: by 2002:a05:620a:6c0d:b0:93f:38c7:64e1 with SMTP id
 af79cd13be357-93f6f79b9e4mr385949285a.25.1792760109819; 
 Fri, 23 Oct 2026 05:55:09 -0700 (PDT)
Received: from [192.168.0.4] ([79.127.134.35])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a2b061ceb7sm2205645e9.6.2026.10.23.05.55.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 23 Oct 2026 05:55:09 -0700 (PDT)
Message-ID: <419c14e6-cf06-4502-bad8-903d6896d4f6@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 14:55:07 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Issue with PyPI when working offline
To: John Snow <jsnow@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Cleber Rosa <crosa@redhat.com>
References: <6e28a268-6ec0-4f83-8d31-76c48634c2b0@linaro.org>
 <9cf3e30b-b2fe-4507-ac57-b437dca14721@redhat.com>
 <eeac5fd9-e03e-43e6-b53b-d0bb2d9e375f@oss.qualcomm.com>
 <CAFn=p-ZkTd5iv9UZCondYbBe6Y3Gudcv8oE-95Ttnh2O8dujEQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAFn=p-ZkTd5iv9UZCondYbBe6Y3Gudcv8oE-95Ttnh2O8dujEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA1MCBTYWx0ZWRfXwu8lNjUZ6Cxw
 0lZyqFNw8OzZ3oriZjANJKBqKetAGZaNbJ1tPoR8FXDmIIbgXDdbWI+XJ1f4mlyZCwh0Zxfd24W
 8NzB07IjsUGJZo/mpIHPRRB9CP+60qo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA1MCBTYWx0ZWRfX6EOQGVrhziaI
 jrc4/0MUDI5mnpVZrSg1JDdS7BrjH78H2e3YbFuYB7Myp/q1N9riOBluTBqdDn963QSubpxFE0Y
 ihaTW3J0f5M8r+t7rxPflERVKvf6lNri1Yuu9+QJX3ec9fpS825zRdmyTdoyfanBPZIT6/nbfLV
 HNbtbTIerXq7MZ+5vUA8MSqppy9E/bK0kd2+SGqwVUf5xl3TcHqeYUg74yZeHpnZILNT++0RFQ+
 +9A5MBhG+UKVYZwjB73K9vg2ozFrCxZs7B/VsRO0CNmYDxf2QpmY7xZxRtPJ9AB+Im2jviUJr23
 6ga1fZHTs78ZYQZKh1780bPs/tPK84yoDW2GzPX7H+WABr0QRWu62noMQDve84Opy/sp2fcI+mm
 Pp4v4LIg2a7mX0a5KmriIChN77QQt27/p2S27KGpTKIChU1qT698NwVI4hQJLI6SsmCUVrlJGsb
 CmV80n9LyPIQFQFz5Aw==
X-Proofpoint-GUID: OzVsc-hnNKpmF2k6Nb-QrOjalD3FzudD
X-Authority-Analysis: v=2.4 cv=YIMKWhGx c=1 sm=1 tr=0 ts=6adb592f cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=iDw3GeftGWU4ZHOe0o4/TA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=CckQENj0AAAA:8 a=-dANsA5_N5zMuR4eR_gA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: OzVsc-hnNKpmF2k6Nb-QrOjalD3FzudD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 malwarescore=0
 impostorscore=0 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230050
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-07-29 18:01, John Snow wrote:
> On Wed, Jul 29, 2026 at 9:30 AM Philippe Mathieu-Daudé
> <philmd@oss.qualcomm.com> wrote:
>>
>> Hi Paolo,
>>
>> On 13/5/26 15:36, Paolo Bonzini wrote:
>>> On 5/13/26 15:04, Philippe Mathieu-Daudé wrote:
>>>> Hi,
>>>>
>>>> This is the second time I'm working offline and do a simple
>>>> rebase, which triggers a re-configure, and then I'm stuck because
>>>> PyPI tries to access the Internet and do not allow me to neither
>>>> build nor test:
>>>
>>> Does it work if you configure with --disable-download?
>>
>> I got this issue again today:
>>
>> $ ../configure --disable-docs --enable-plugins
>> --target-list=aarch64-softmmu --enable-tcg --enable-kvm
>> python determined to be '/usr/bin/python3'
>> python version: Python 3.14.4
>> mkvenv: Creating non-isolated virtual environment at 'pyvenv'
>> mkvenv: checking for meson>=1.5.0
>> mkvenv: checking for pycotap>=1.1.0
>> mkvenv: installing meson==1.11.1, pycotap==1.3.1
>> mkvenv: checking for qemu.qmp>=0.0.5
>> mkvenv: checking for setuptools>=44.1.1
>> mkvenv: checking for wheel>=0.34.2
>> mkvenv: checking for pip>=20.3.4
>> mkvenv: installing qemu.qmp==0.0.6
>> WARNING: Retrying (Retry(total=4, connect=None, read=None,
>> redirect=None, status=None)) after connection broken by
>> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read
>> timed out. (read timeout=15)")': /simple/qemu-qmp/
>> WARNING: Retrying (Retry(total=3, connect=None, read=None,
>> redirect=None, status=None)) after connection broken by
>> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read
>> timed out. (read timeout=15)")': /simple/qemu-qmp/
>> WARNING: Retrying (Retry(total=2, connect=None, read=None,
>> redirect=None, status=None)) after connection broken by
>> 'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read
>> timed out. (read timeout=15)")': /simple/qemu-qmp/
>>
>> Indeed using --disable-download fixed it.
As of today's b6c4b7e86dec:

$ ../configure
python determined to be '/usr/bin/python3'
python version: Python 3.14.4
mkvenv: Creating non-isolated virtual environment at 'pyvenv'
mkvenv: checking for meson>=1.6.0
mkvenv: checking for pycotap>=1.1.0
mkvenv: installing meson==1.12.0, pycotap==1.3.1
mkvenv: checking for qemu.qmp>=0.0.5
mkvenv: checking for setuptools>=63.1.0
mkvenv: checking for wheel>=0.41.2
mkvenv: checking for pip>=23.2.1
mkvenv: installing qemu.qmp==0.0.6
WARNING: Retrying (Retry(total=4, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
timed out. (read timeout=15)")': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=3, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
timed out. (read timeout=15)")': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=2, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
timed out. (read timeout=15)")': /simple/qemu-qmp/
WARNING: Retrying (Retry(total=1, connect=None, read=None, 
redirect=None, status=None)) after connection broken by 
'ReadTimeoutError("HTTPSConnectionPool(host='pypi.org', port=443): Read 
timed out. (read timeout=15)")': /simple/qemu-qmp/
^CERROR: Operation cancelled by user

$ ../configure --disable-download

ERROR: missing subprojects

--disable-download specified but subprojects were not
checked out.  Please invoke "meson subprojects download"
before configuring QEMU, or remove --disable-download
from the command line.

$ pyvenv/bin/meson subprojects down
load
ERROR: Directory . does not seem to be a Meson source directory.

$

