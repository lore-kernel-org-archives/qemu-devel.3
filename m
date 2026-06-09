Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D5B1CD8CAA
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 15:09:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWy4n-0001gW-47; Tue, 09 Jun 2026 11:09:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wWy4b-0001fU-Cs
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:09:02 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1wWy4Z-0001wc-IV
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 11:09:01 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 659ClchV2183230
 for <qemu-devel@nongnu.org>; Tue, 9 Jun 2026 15:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=XSJkJOkv5emanZXmVaBV5ypah2GhgL0GbaT9gE/zfj0=; b=aW
 YF7DKg4yapFbFb/23F9cDt8RYcBeYIiYu00sGX4f4VCY0o2eekhTu+uekWccPx1V
 mf5hcEUJ1kbPcN+VcOOtIdcc9AhVzBDaGEbpiWHbhgYe8HWgTA/gdlcjAT7LESC4
 0cuMcSMHjUXFwO7lzWnRFkHyTxI0iazRk+2939cgA0TF454KVn7/75YAKUH9DclY
 V9LFec8y9vygEM3MtZ2BVVKCTMirbOfTAUNv0sDPWMPmFNXj8ZtL2lxQq1EGirrJ
 4Ioh8ySpiatMtaKBht36/QDlaiTmeZwCYpEqqs0q2hoLEQMZS80JgrKcFpg/ZRtG
 CVX3+pp8THylqdPS6oOA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4epenra3uw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 15:08:56 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-7dcd01ca614so111099297b3.0
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 08:08:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781017736; cv=none;
 d=google.com; s=arc-20240605;
 b=km2E6ZkMm+78Fju7zGXSs5jn1vGsv+bAS9KDdqyEZxLCm/SVYidPTqlxiqDZwL4hSb
 1s7hou4MD8lksrdKrTUrVNA+kaN3K8YQiiDYFiKEcFlNvmjXG5/62Hq9ymxb8r+lWX5K
 EjiTdLzvnUFy5y2I1PIVIpwz6by3O7SI68lQ1NLlTeunLH398OU1cMw/mto/rpon0m1Q
 sorQ3M01GFMjgLXS6GH6m4kr5ggjA5mMYMewnkAKembzK1TbN5gcF3hHnd0FFSWsWFGi
 RzDFGA8BPBq/wiaMlI9XcrW07Nq5YaTA1HyyqjOTZuy/RGyTuwwIBpxLTz2GQ/9H4BFI
 Dr7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=XSJkJOkv5emanZXmVaBV5ypah2GhgL0GbaT9gE/zfj0=;
 fh=WTOzYAc+ZKuH6LS1VmVRLDW4tDZnD7sHjb6zYzkF+F4=;
 b=PKP2ylpX2rshqxOf7DgKZN68npofUYLwZcWwn5AHWCtuC34rVnzEawivVoH+wnFiDA
 2h6LA7yTyrTNYpxqJuDFBWkbYvm/ih/c/J1vt//HR/C9YT9FL7lzW8XxLAMpD896CLE6
 Xn92KCx7rIiz+Ky29Onj/yavJ0QJ8GUHPV7T6S+Coon9i0pNmFoRb+u+mcpcG8/ETXdF
 Yc1Z3vXZ5KVMTZvXuLdkRMJxBiXKb2gVbVY6B2QMq2MxQil5u3TWB9Im7KB5fDIa5zDC
 DdG51cppVHT/Sra1JKYHc0kNAKNouC/2FwXE4mvbjb8a67c7LoltoZAsCH5Tx6qXwF+f
 jjXQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781017736; x=1781622536; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=XSJkJOkv5emanZXmVaBV5ypah2GhgL0GbaT9gE/zfj0=;
 b=Drk6xOBScEr+M/YTRObls15xkm53k5lgUTzZ0+ttmYZA4ivud4Zzx5fvY4G6DZ6h19
 MvSIlzU+SaUHPbfd2Jkbp5pWZ1u5tV/90DC8wJZOd7SQaJcR9mFNDdJGL8zGiTQfBKBK
 U3gflx7n1jOjAluHtCIZbvqjmJ7O2WYgNZJuAAaObDjoR34IDAWGoS15hDx1aZ6a7lzv
 hdkzkhg2q/96iOEwNi6Hh64ABMgVbYVal//VkmBNC5eiljT1QfgEECWIAaQSb5k2O7x1
 7VQRcAzgDg90XhbwRiWr/HWXHbc3Q717HPBjqbmoDgNEZLGigh6zxhkeWFOO81gMi6Ww
 5kEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781017736; x=1781622536;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XSJkJOkv5emanZXmVaBV5ypah2GhgL0GbaT9gE/zfj0=;
 b=LpsJkNHls7/+PyimIcH/XWFfzmEC9eYswotOSubN+yKNuQMkYcGMaxbzQaDb5k0KSk
 EOcCJTyCuWU7tCPwz1SH4/VWZgl3rd2TlDg02BNi385IclF5hxtOW/OSG3ftWelCcFXT
 sJQvGyfXynrkq9wVeFVJuBWKNwfPEHKuxfvBkJvkCyiDgT0BRUaqeF7bgu27s5ihHfTG
 RQPa6yMOPt7c0RZ2y9nVAVGaYThXW0qTKQVW3exVhU4xf7wuLT2OqkPX62x8G4Nxr1uW
 s5GHBZD+/EgEBQZRht1infICeHRxL2wp3E5D5erLQ9Q5mQ/udNJtnJSie425mQlxjzTU
 yzzQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+GE/s3Kkqj/hOx0hT3sgkrdVD6DIqcpJrFWJtyMSRSF9I0xcInAhSvs4lwozivgJwCdl6rInsZ3xSN@nongnu.org
X-Gm-Message-State: AOJu0Ywseji6pdaijVkqXdX6mYLox7oE6WJiUc45Q9a9H0gUboukRp8x
 /Fb+GFvmEKkKn6w11yOud8V79Ke8bAGxPnCIbp5BheqO3qj3jbHaWQ1LisfZMX8+CQ8EUvAhpf4
 FebNIjbHnLitBJ3Iqo42uHO/b16b7kWP+2+Iah4OmBM4BOmOZrjcMxULDnPDMsSi10tWgOat8JC
 vs4iAAT/jH7g1tJASntGRiWeyJHN6bK7jG
X-Gm-Gg: Acq92OGaSkVUQwk21Mgw7To0l74BmZlhT/Lgg8NoWxBYUmzyFX2kU9lK6f7rLv10u7P
 RPlihdd0o7l8Vt48mSGad7sqdpW3FfG7bCL6XStmf1yqZ0jm0eqv+lsejysN+ato5UM0vyZ3Uo8
 oknGGIkr1iNZRBYOBUyygh3R4ZvNisiHZqIyPT325UIeTnLE9DbmcjhWaoLYec8XI9nmfquRLKb
 4Rk8OR3ibF3OyXqfg==
X-Received: by 2002:a05:690e:169e:b0:651:bb21:e7fb with SMTP id
 956f58d0204a3-66106fada73mr16754337d50.54.1781017735489; 
 Tue, 09 Jun 2026 08:08:55 -0700 (PDT)
X-Received: by 2002:a05:690e:169e:b0:651:bb21:e7fb with SMTP id
 956f58d0204a3-66106fada73mr16754286d50.54.1781017735028; Tue, 09 Jun 2026
 08:08:55 -0700 (PDT)
MIME-Version: 1.0
References: <20260602074127.63819-1-cp0613@linux.alibaba.com>
 <20260602074127.63819-3-cp0613@linux.alibaba.com>
In-Reply-To: <20260602074127.63819-3-cp0613@linux.alibaba.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Tue, 9 Jun 2026 20:38:43 +0530
X-Gm-Features: AVVi8Cdle_VEyRYddsF24uH6tQLmZBOOPx2_3oluXiglzFIVuBVf9t38z5J41_M
Message-ID: <CAB19ukHaz0xJrL7-WSdMaK+Sodk1mgbim_L=AQdsPaLg4Pf44g@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/riscv/virt-acpi-build: Add _DEP to ACPI0017 for
 CXL host bridge dependency
To: Chen Pei <cp0613@linux.alibaba.com>
Cc: pbonzini@redhat.com, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 sunilvl@ventanamicro.com, jonathan.cameron@huawei.com,
 fan.ni@samsung.com, guoren@kernel.org, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: FsR1XbQ01389d_YY8VXUrKMybFiexGRa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDE0NCBTYWx0ZWRfX9TN2H0RorCP3
 9BbKn7aw2o+8GNcwTZepWkPYbBzlrEAV3mznWVcrTTzrnBOZvg7j4KZpubySYMpnpASZM2nKWla
 0+DGsMGCH4HFE2EitAZyWNXTawWpwtF2DNrkky9a4KqCHFkbvEm4mrqgSY/4ozCN/2Q3Utxw13A
 thhx6+EQve136WBdDU+rAxwR+IAK0xpKl6NmKT13NenXcUdIiy5XPfmSNeOM5wLLXCg6atcNPwv
 tyuWfrt0VUIHTss/WfHT3lFrpv/VuSMl76Q0R29ktBaxcxH94XyFSrvjJGcpJYPi3ZdhA6lI035
 D9MNtVVGWF6cL3A1XuADw1eWSDEzBPpCMSWq4aosKAD9hWICAQxDCAyT6I3f0XmfR3BssjHzPpJ
 +UUKk2AB3xhonOx+FvRX+L/KYennlJ8/mh2roXai5emLEMsP6r8q52sc12dOEr6NXDBiillFtwR
 VPz7mKbyyHRNnl4+2Sg==
X-Authority-Analysis: v=2.4 cv=NKPlPU6g c=1 sm=1 tr=0 ts=6a282c88 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=_K5XuSEh1TEqbUxoQ0s3:22 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8
 a=65xJDWIeJbAoLFq9lykA:9 a=QEXdDO2ut3YA:10 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-ORIG-GUID: FsR1XbQ01389d_YY8VXUrKMybFiexGRa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090144
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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
Reply-To: sunilvl@oss.qualcomm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Jun 2, 2026 at 1:18=E2=80=AFPM Chen Pei <cp0613@linux.alibaba.com> =
wrote:
>
> On RISC-V QEMU virt platform with CXL enabled, the probe ordering
> of acpi_pci_root (ACPI0016) and cxl_acpi (ACPI0017) is not
> guaranteed. If cxl_acpi probes before acpi_pci_root has attached
> the CXL host bridges, the CXL port topology will be incomplete
> because to_cxl_host_bridge() silently skips devices whose PCI root
> is not yet ready.
>
> Add a _DEP object to the ACPI0017 device in the DSDT, declaring
> its dependency on the ACPI0016 CXL host bridge devices. This tells
> the OS to defer ACPI0017 enumeration until all ACPI0016 devices
> have been attached by acpi_pci_root.
>
> This requires a corresponding kernel change to call
> acpi_dev_clear_dependencies() in acpi_pci_root_add().
>
> Signed-off-by: Chen Pei <cp0613@linux.alibaba.com>
> ---
>  hw/riscv/virt-acpi-build.c | 32 ++++++++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 309d64b322..a5bafd1dcf 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -510,6 +510,38 @@ static void build_dsdt(GArray *table_data,
>      if (s->cxl_devices_state.is_enabled) {
>          Aml *cxl_dev =3D aml_device("CXLM");
>          aml_append(cxl_dev, aml_name_decl("_HID", aml_string("ACPI0017")=
));
> +
> +        /*
> +         * Declare a _DEP on every ACPI0016 CXL host bridge so the OS
> +         * defers ACPI0017 enumeration until acpi_pci_root has attached
> +         * the CXL host bridges. Without this, cxl_acpi may probe before
> +         * to_cxl_host_bridge() can resolve the PCI root and the CXL
> +         * port topology comes up empty.
> +         */
> +        if (s->bus) {
> +            PCIBus *bus;
> +            uint32_t num_cxl_hbs =3D 0;
> +
> +            QLIST_FOREACH(bus, &s->bus->child, sibling) {
> +                if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                    num_cxl_hbs++;
> +                }
> +            }
> +
> +            if (num_cxl_hbs > 0) {
> +                Aml *dep_pkg =3D aml_package(num_cxl_hbs);
> +
> +                QLIST_FOREACH(bus, &s->bus->child, sibling) {
> +                    if (pci_bus_is_root(bus) && pci_bus_is_cxl(bus)) {
> +                        aml_append(dep_pkg,
> +                                   aml_name("\\_SB.PC%.02X",
> +                                            pci_bus_num(bus)));
> +                    }
> +                }
> +                aml_append(cxl_dev, aml_name_decl("_DEP", dep_pkg));
> +            }
> +        }
> +
>
LGTM.
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

