Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AC2C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 18:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x40uJ-0001Uo-L1; Tue, 08 Sep 2026 14:50:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x40uI-0001Ua-79
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 14:50:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1x40uF-0004o7-Vr
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 14:50:57 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688IDJY93666560
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 18:50:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q4uxhD4zrmBO9r5xm60fgzvs2acm1edZj6z5KGOCw2k=; b=OXT2nJ76IqNw/G9i
 a++rooSxxaw6xiBxVgnbdXyTQz9ORDeCfxoUqWfms0s7BDv7FSKzlZ1afFyp1M8Y
 w1ABBt8jahMdB3o47k6scdCgAej4/ez3QCaalXNxW+/5iU0lBQz32WsImKMhmEys
 XzQppsbq5ch4LPSdTC/VQe9dXuOqUh1DnusPr3TSN1SsUBE5XUZPW7+u4sjyr1/b
 rr6kfMGVpsXd/WV9Pa1ZfT/Rq8TGkKnmlw6Dlgp/vI247VUytrNyLmKVfcSHBw46
 D6nwGg4w3UqC93KaVjonB9COl5PshqKq1vSheOKTz4EhlF3k9cob1vpQRrDINA1V
 B5/+rg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjqewg5k8-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 18:50:53 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-9390a2c895bso991988785a.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 11:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788893453; x=1789498253; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q4uxhD4zrmBO9r5xm60fgzvs2acm1edZj6z5KGOCw2k=;
 b=e+IeuJKXJp3Mhm4TnBuVgU2SXQhvC1O8Ip4zQZR3apD5B4asvUAG9zgNvXTrnfi7rR
 yCz4Vi/FEBI05XnuG17rC1eBAoQyzyXYgGS1f2cb4UopuPQHE9Es+/g91JSaKcDu/TlA
 Vu5jZ0Unq9K0K3g15fSEN+oqXi/2Qv0QZrrzmPXVGxkmhMTT5w3JTlFYgLWLU8n82n7k
 FsRj3T2i+vAH9rpGTCL73ttghS5JVExP9dVWCWm2vG3mUxnKgqvXiPpQ6xNRBWTXEVgO
 /lN93JypoCBUr0VAzHv8q59LpxKEbQiCwv3uA/YUDiXw+YKWsc5Oc4c9i7XrM8amzZEz
 hQOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788893453; x=1789498253;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q4uxhD4zrmBO9r5xm60fgzvs2acm1edZj6z5KGOCw2k=;
 b=fGdKWRYKADV/b6J3m1Kgqh7yEnL063lzneOQ9Lh5iviMgL4sseBjYONcwPMdpP74AJ
 hu/1I6wT3CkxVEBpPfwjvBHf6okB2Mrc0pN+wyyJ1AOsT2ZdL24riepp79RDIAcxOZBP
 dFTFAzzsQrkrEEwHb87+OFq1rcJR0N/cfjGNUaoGjlvMPxCJZKK7C4s4QIJf1hejKuni
 lfsGFy3AoK+QJiIAu6uZudQ3q6tjdQJCsaJMno6d6iKt73iDTGb2MPhIsdTPByNTtdCB
 mbEn9LeK7WKp+ugBxa2CtTA603MRDOHC9+sB6uIp9oK1cJc9W48xpJq+OX2OaJphdMgR
 /Lyg==
X-Gm-Message-State: AFuF++kd9eyFFVQ6NrH2CLP4DcHJCTo5P/EYqvpp6zfla+aFJPPjaWT8
 pILWh58cUvVTvR1bqlJ4xixm+oR9BcIziQJ1+6c7xH6Lj2aDfLmLjzl5J3dEQFK7eNib18uqOUl
 /L7Qy5rMxLqNYHzXpf0Nar7pOMYwrNp4tK+HrgS5F2Lc0er26EvU+KJho2Q==
X-Gm-Gg: AYBFou1qt75w+ZbYW5yWb+XUcBjX4TeqPlwViVkoVJ3QpNtamJHFsA4/6/Z1fzPlt/o
 MwL+pY45OllQRHEUiPKkIrtUGTLZ4j/1Yo7BxFv7OCUkxItHnFIw8ubsoB6A0m39hHsUm0W8qCD
 HbT55zjcQsMzoSvY/gGgZxYcSV38v+HiM+rtF+xzkB8fhcaB5R9yGwPMgGI+xg0cxh+/GBENZcc
 AP8mvc4ow0y4SfgbO5enPtFNukb61UuqDzB6DzNF+3YJ2NJQOpmcZfsldHP6lm5dCnXOCBhy8MH
 RJazew80hghEHBUUvBqY0RXSqvV8GtmFQqnjwLfakyDDOOrYsH26/ljLYuvGJR1DWRGGvtW+T97
 0MW24qm7MqssBLGdg6ZIzzODsUamAdZFlzKw=
X-Received: by 2002:a05:620a:4610:b0:939:4a34:621e with SMTP id
 af79cd13be357-939806da32fmr3093287185a.28.1788893453346; 
 Tue, 08 Sep 2026 11:50:53 -0700 (PDT)
X-Received: by 2002:a05:620a:4610:b0:939:4a34:621e with SMTP id
 af79cd13be357-939806da32fmr3093257585a.28.1788893450568; 
 Tue, 08 Sep 2026 11:50:50 -0700 (PDT)
Received: from [192.168.68.102] ([177.18.66.131])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9397fb33619sm1206417685a.22.2026.09.08.11.50.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Sep 2026 11:50:50 -0700 (PDT)
Message-ID: <b7a2f727-55ac-486c-85b9-6662c597a30e@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 15:50:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 5/5] docs: add riscv-server-ref.rst
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu@processmission.com, leif.lindholm@oss.qualcomm.com,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260904195610.964829-1-daniel.barboza@oss.qualcomm.com>
 <20260904195610.964829-6-daniel.barboza@oss.qualcomm.com>
 <wbr4q627iwaqltkrqds2qoz5jnupjhmf3x3eb5bf2o3orf35fr@dpjs2pzvkten>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <wbr4q627iwaqltkrqds2qoz5jnupjhmf3x3eb5bf2o3orf35fr@dpjs2pzvkten>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=cpirVV4i c=1 sm=1 tr=0 ts=6aa0590d cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=CQQxcbsX5Byh3TlVSSGwig==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=NEAV23lmAAAA:8 a=NLiCwHATAAAA:8 a=EUspDBNiAAAA:8 a=JF9118EUAAAA:8
 a=FRSEYCzRAAAA:8 a=XWWM0xVod75z28mxWacA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22 a=F9tHCgz3TLBaZgltkx5D:22 a=xVlTc564ipvMDusKsbsT:22
 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-GUID: GkBzaLr5e2VkFUsXuwyR-wAQ_1p9M2xc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDIwNCBTYWx0ZWRfX+uBHEPo6P7PE
 UJBdHtSTwu/XicfxwKc/5t+bJ8CjYn0weVd3nMNBArERgg5/gF7GlSOWIh5REXcAUM7S8YMd0xs
 rC9yt+aLD2X5MCofhmWWmarWh908UPJKF+RcHs7EVucZ/6AQaTzryd6CkNg4d13nHB8G8Y8tnF4
 opMdD/a88xdekcyUA7pYHdkR1y12EP3Gc1BVHxnGCIlmk2+AzC94L/xwyFpCX+KJ9nk8jkZ85Wk
 9nUZ/N028YitmaNVeML+cbrA7zKMg6fG6QSqTcDinOanknLxUiDsoaQJ3MaWZQUnBlrGHRty277
 +DNRKogDVgo0MLxRT1TKT0R8bA7YKWwIXiTO+0qSuU39XqFwRBx30kRrArTY/EM4oQq5h4N3l86
 en/ihVN/SwGBMs5cFuC+vOycLVYHj2sJ9sQ4mxAM9i/ik9LImAmqEBneCh0AoJ3VSxTXooJTXZE
 gZRfm9VbYHeP/GouV7w==
X-Proofpoint-ORIG-GUID: GkBzaLr5e2VkFUsXuwyR-wAQ_1p9M2xc
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDIwNCBTYWx0ZWRfX6jWZwlREAFdr
 9hqQhjwq6XqqkzAussQpGwmqzQNsEKRQ21qkzjPyV9cFxO6aGK4raFEPiHrgpXTFhbue67oAx6q
 i9XuRKXTgQRiPGORafYqJeyr+0rztU8=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 phishscore=0 clxscore=1015 priorityscore=1501 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080204
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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



On 9/8/2026 7:05 AM, Andrew Jones wrote:
> On Fri, Sep 04, 2026 at 04:56:10PM -0300, Daniel Henrique Barboza wrote:
>> Add documentation for the new riscv-server-ref board.
>>
>> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
>> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
>> Reviewed-by: Chao Liu <chao.liu@processmission.com>
>> ---
>>   docs/system/riscv/riscv-server-ref.rst | 62 ++++++++++++++++++++++++++
>>   docs/system/target-riscv.rst           |  1 +
>>   2 files changed, 63 insertions(+)
>>   create mode 100644 docs/system/riscv/riscv-server-ref.rst
>>
>> diff --git a/docs/system/riscv/riscv-server-ref.rst b/docs/system/riscv/riscv-server-ref.rst
>> new file mode 100644
>> index 0000000000..0573b4e07c
>> --- /dev/null
>> +++ b/docs/system/riscv/riscv-server-ref.rst
>> @@ -0,0 +1,62 @@
>> +.. SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +RISC-V Server Platform Reference board (``riscv-server-ref``)
>> +=============================================================
>> +
>> +The RISC-V Server Platform specification `spec`_ defines a standardized
>> +set of hardware and software capabilities that portable system software,
>> +such as OS and hypervisors, can rely on being present in a RISC-V server
>> +platform.  This machine aims to emulate this specification, providing
>> +an environment for firmware/OS development and testing.
>> +
>> +`spec`_ is version 1.0 at the introduction of this board.  New spec versions
>> +might trigger a revision of the emulation itself, which will strive to always
>> +match the latest version available.  In case the emulation changes aren't
>> +backwards compatible we'll introduce a versioning scheme, probably via
>> +a machine property, to allow older SW to run with older spec versions.
> 
> We'll want a versioning scheme even if the new spec versions are backwards
> compatible because users will want to be able to test their software on
> strictly the older spec reference models, not just compatible later
> models. That allows them to be sure that the software isn't using anything
> provided by the later models which is not provided by the older.

I'll change this to:

`spec`_ is version 1.0 at the introduction of this board.  For each new supported
  spec version a new versioned board will be added, keeping "riscv-server-ref" as
  an alias for the newest version supported.  E.g. for spec version 2.0:

  * riscv-server-ref-1.0 - board that complies with spec version 1.0
  * riscv-server-ref-2.0 - board that complies with spec version 2.0
  * riscv-server-ref - alias for riscv-server-ref-2.0



Thanks,
Daniel



> 
>> +
>> +The main features included in the riscv-server-ref board are:
>> +
>> +* IOMMU platform device (riscv-iommu-sys)
>> +* AIA
>> +* PCIe AHCI
>> +* PCIe NIC
>> +* No virtio mmio bus
>> +* No fw_cfg device
>> +* No ACPI table
>> +* Minimal device tree nodes
>> +
>> +There are multiple ways of using this reference board.  The spec compliant way
>> +is using an EDK2 image and a TPM device.  The board was tested with the TPM
>> +device ``tpm-tis`` that uses the external ``swtpm`` emulator.  More info on how
>> +to use this device can be found in `tpm`_.
>> +
>> +To use this board coupled with the tpm-tis device, first start the ``swtpm``
>> +process in a shell (the ``log`` parameter is optional):
>> +
>> +.. code-block:: bash
>> +
>> +    $ mkdir /tmp/mytpm1
>> +    $ swtpm socket --tpmstate dir=/tmp/mytpm1 \
>> +            --ctrl type=unixio,path=/tmp/mytpm1/swtpm-sock \
>> +            --tpm2 \
>> +            --log level=20
>> +
>> +And then start QEMU with:
>> +
>> +.. code-block:: bash
>> +
>> + qemu-system-riscv64 -M riscv-server-ref \
>> +     -bios fw_dynamic.bin \
>> +     -kernel EDK2.fd \
>> +     -drive file=nvme_disk.ext2,format=raw,id=hd0,if=none \
>> +     -device ahci,id=ahci \
>> +     -device ide-hd,drive=hd0,bus=ahci.0 \
>> +     -chardev socket,id=chrtpm,path=/tmp/mytpm1/swtpm-sock \
>> +     -tpmdev emulator,id=tpm0,chardev=chrtpm \
>> +     -device tpm-tis-device,tpmdev=tpm0 \
>> +     -nographic
>> +
>> +
>> +.. _spec: https://github.com/riscv-non-isa/riscv-server-platform
>> +.. _tpm: https://qemu-project.gitlab.io/qemu/specs/tpm.html
>> diff --git a/docs/system/target-riscv.rst b/docs/system/target-riscv.rst
>> index 2639866a3e..74e23fa64c 100644
>> --- a/docs/system/target-riscv.rst
>> +++ b/docs/system/target-riscv.rst
>> @@ -70,6 +70,7 @@ undocumented; you can get a complete list by running
>>      riscv/microblaze-v-generic
>>      riscv/microchip-icicle-kit
>>      riscv/mips
>> +   riscv/riscv-server-ref
>>      riscv/shakti-c
>>      riscv/sifive_u
>>      riscv/tt_atlantis
>> -- 
>> 2.43.0
>>


