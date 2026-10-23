Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC4A3606A33A
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Oct 2026 11:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=C0ZfkutV;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=htifg40u
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xKDvA-0007wS-6U; Fri, 23 Oct 2026 07:58:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xKDv8-0007w6-Rx
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:58:50 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xKDv6-0000Ct-RK
 for qemu-devel@nongnu.org; Fri, 23 Oct 2026 07:58:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69NAAT3q3550517
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:58:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=0PLmUWQ+/NloAxyYKu+rECMhkCWWXqEjLtTxTMUCph0=; b=C0
 ZfkutVoOGSMSG3iQ7QLGI1CTXtXTUwfSBb2W5+J7elFzvGHZvToQBo+XQjo06+6W
 jxsIMdFU8Z44fIOEpd3tjE3C2y3duNSOcNGme2Bb4d++CMCay2ZoceQA5IRLwZFq
 6UFu46fEU1VczugHj8muMqixlW/gmTF4Sj2JKVv5h4thSB+E7LuP39d37B70tvyq
 SP8sKtL5yS6DX1pGwtT+9q5UqKb5menHmZrb4hTLUUGk6JZ65F8UEJySk2l/SjGu
 yMrCIbCupTiHTgJZotPr1HImUXUuSZRmwgMeD7xnHI31aMhN1v8LNOhIyK5GcTNU
 TAjSrVdwv69pFn38/8dQ==
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com
 [74.125.224.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hfqmrbh83-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 11:58:45 +0000 (GMT)
Received: by mail-yx1-f69.google.com with SMTP id
 956f58d0204a3-6755fef4f96so1396514d50.0
 for <qemu-devel@nongnu.org>; Fri, 23 Oct 2026 04:58:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792756724; cv=none;
 d=google.com; s=arc-20260327;
 b=rs92ZIi8gtldHMFdkbXaezz5qzeexCf8NxITwWTumzyX+c1QaLK3lDd6YmLLisAqtP
 ozFsL9R7ZPjuCixuoMpTtRpfR+echp5zjCY8jE7NkYkfBbfgfCOEdoGuXeQggDmd5+Rm
 s/Njc4oiWjxv5ZllJ1IjRkEtWEnatE1cahdq1TenvAkBdC/mbE2oWQaxf3273ixjtfoZ
 WK5TcZr14j8ydnnn5A8amuuvlglg7tNiGOLSGdKmEwklc6i6XIG4IP4ZfiB2q2/Ul237
 c1R86Ams1kmfDTtCYib1pFiKoPNlLoYlEwB703XU+cv8WYet9n/YceumYK/J4nT1uHr5
 AzwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=0PLmUWQ+/NloAxyYKu+rECMhkCWWXqEjLtTxTMUCph0=;
 fh=qFHU0N3+AcNjVQQ1nmtMTlHfRnvBYVuabD+LTORcSv0=;
 b=GubVFRLNnM63LljFZagNY0XvhLm8sew4pbOua+jmVMrnzAQ9PdhcUrB2LLtdKEmhnW
 YgIEQIItxAm5gknfJO3ywYNCvSVbbdSRXcdWKNZIvIf5dsg8c81Bfcx1fV14S8sirqgl
 pjWKkGaq1h+UzUotepf5JwknMhr9hqFFtQsA+CxMo8yV0Ox8gQTRDgviW9bLNJv+5MwT
 5qr7Rm0U1VmVMu4MfDVypUmlA5iXOTRW64VV8uyp51h6FMwHed9mfdEj1ZLm2VImwjAC
 5XqdgjJw8fb3IIOJUSSu+8+tyIrXw8Pk1WqSZWrjPdiHQlcK7D6MxxPWSUE+iS8jPT7q
 gF3g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792756724; x=1793361524; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=0PLmUWQ+/NloAxyYKu+rECMhkCWWXqEjLtTxTMUCph0=;
 b=htifg40uguf0389WanevklJQSWJ/H6lInHr+hHokkE4EW8eaxeElqCWyWZB09sZOoD
 u2YQi9CaVAjati0PFgZ2kEpwJ9HSFn4JspGUHaKG7xNNBLy0IEaxMf+juxXKQW5DQvj5
 1FQR6///eof5eiplmSMBTS7sWldv/ZaXkuJLXbbMpHzrSnXS9XCjcfwzmSJyFu2fVzwM
 msfSC085gtbZHHnRPwmI2Gd5LDG6AopB9AMic9VNTs4wTTYnNRYaB6HNWJp2NrNDFRVI
 dhn16B9FZ2a+t1ZKIVU8u16sWGvs11MLwHFC7poYFsDCfnrB3cOLGWjGT5Qnb7VUWLyX
 3LKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792756724; x=1793361524;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=0PLmUWQ+/NloAxyYKu+rECMhkCWWXqEjLtTxTMUCph0=;
 b=hOf9oWHp8J/CVFHypY2JXBkqZO9Cr/waP+ecnw1H3Y3EnxjX9OqvWCeiRlIRpgTGQJ
 ATLvTpd1Q9Hqw15py210ksHPLcSbFDASS6ptGxl+EdLS1/EfbSo1IHsaxcMKcYFXaUQi
 UOQ9ry4FKCyIpslHq+TkSR5JbM9wnvXgvAhqtbS6PX08MlAoOX+jQ56NgJBox9SEl7pK
 XNocdC4ouwCk0yEq4mgyHo7BBNTncivNzyoxAsOOfpAlK6S+FR/iaL/9R7SnlycQgH3o
 LzeIA10pmcWnWQ7rnUUn0c3VwXOtGgJWb2mVRrZZ9yUyWtPcDJgoJxbY9qYtWuGQvUDm
 YtTA==
X-Forwarded-Encrypted: i=1;
 AKwUvByaSSOJydgweGnV2vbE7cJUMPQvOBt3NYiTHus5e4LehP1uQ4QUvNNdBKIE2OuzEvbYvqFQOJm1oWVc@nongnu.org
X-Gm-Message-State: AFq9FYIgr92sPOsvXb2UsKRzIKTTVmnBPccISRV/E+XminWaoRJioL1E
 4Cr+PvUumiXTwPV6jnLsp859Hv0P4Gel3waJvRyuVJ50ujO3rpUzCNJlBiYJ7h7xXxnQUMgBTvH
 xCS3E0fAypzKpZ7ULBm6n3sQQ1fL41ffwpp4KF/ia1pdzvC9757jfEaowmBzzXoKWEYZTcqnwse
 XJUCHMdEP2hSox1RIc8hfxGdnn3+fcWRsU
X-Gm-Gg: AYBFou1l+M76I3ThIneHdF6GA37o8lgKUFawyrJoPiLP2jqIxyWLnMAdXdxaJ0kLx4o
 h49tnnkiBKCb1MOUuzAV+AhzukTS1hVb5X3IDy9fGnejSNoK/VwMZBfh2fBDa4CCxOavYIRlHAo
 GE82oqhGDGFM+Aqq7w36fH9ZDewoz2POBA2/nnkRzPAtsmPMq+JcalH26tAA==
X-Received: by 2002:a05:690e:1384:b0:679:ca9b:db2 with SMTP id
 956f58d0204a3-67a35c928b0mr1290648d50.79.1792756724009; 
 Fri, 23 Oct 2026 04:58:44 -0700 (PDT)
X-Received: by 2002:a05:690e:1384:b0:679:ca9b:db2 with SMTP id
 956f58d0204a3-67a35c928b0mr1290632d50.79.1792756723591; Fri, 23 Oct 2026
 04:58:43 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261015064957.4076464-1-sunilvl@oss.qualcomm.com>
 <91f1cd890aac1907f335ce3fdd22e6adf685c594.camel@wdc.com>
In-Reply-To: <91f1cd890aac1907f335ce3fdd22e6adf685c594.camel@wdc.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Fri, 23 Oct 2026 17:28:31 +0530
X-Gm-Features: AclHuK-dOwDva1P0pRSvRyNRyTGonGKTM_zWmncJOdwjKo6t52hezvPScgS4JTE
Message-ID: <CAB19ukGtrbCV8s_WKnE2vDF5P4iiyPXYhyyJjqTu-S0823mjUg@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] RISC-V: ACPI: Add PPTT support
To: Alistair Francis <Alistair.Francis@wdc.com>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "anup.patel@oss.qualcomm.com" <anup.patel@oss.qualcomm.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "shankar.c@oss.qualcomm.com" <shankar.c@oss.qualcomm.com>,
 "daniel.barboza@oss.qualcomm.com" <daniel.barboza@oss.qualcomm.com>,
 "anisinha@redhat.com" <anisinha@redhat.com>,
 "prajwal.n@oss.qualcomm.com" <prajwal.n@oss.qualcomm.com>,
 "palmer@dabbelt.com" <palmer@dabbelt.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>,
 "mst@redhat.com" <mst@redhat.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "fustini@kernel.org" <fustini@kernel.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: a4FazPKC_ZoWxjOcWuNdGcDmXK5BqRaW
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX7PWwWYNp71oX
 cFgsdaOyxBQSHpONVQWT3LgEk1vssJXZFm5xFBlApA6PGD7j0uDJCKwYXNIMZLfmP9qRG8sIPs7
 hpCPHZ0aYjg0FZ/PGdSd7KtdiVyg6JQ=
X-Authority-Analysis: v=2.4 cv=VNZIDNPX c=1 sm=1 tr=0 ts=6adb4bf5 cx=c_pps
 a=J+5FMm3BkXb42VdG8aMU9w==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=Um2Pa8k9VHT-vaBCBUpS:22 a=mDV3o1hIAAAA:8 a=JF9118EUAAAA:8
 a=jpbRcCGOh1f9686tOKUA:9 a=QEXdDO2ut3YA:10 a=Epx66wHExT0cjJnnR-oj:22
 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIzMDA0NiBTYWx0ZWRfX1fTp/iqXr9Of
 Kkhq5dZK2ebmPCrGiJRekiMriK68Qo6KZrExrlcYwPF0zO//7MdW+X2qbFnHw72jhw/T1M16wlh
 KdNo8knJFNwMiV43alLRcxSlg3eV/aNmkZwijV/1Cbc0+0zdyic3TZcT3ZeLPUzMQmaDVjxUxEZ
 AC8aDHui6woh913+Fs6S9tncxEoqV7iM2h8WcpozVpbAFfBDMU1RqbwrLQFJP8E5jt2JhjElYFu
 BmjnPuUgFXb/FFxt02UxKnXd5W12SBdpn09O9WjxpbZkLOBUtKfc7nPsONAei3sZtIU58NMgu5Y
 eQGhkKeFB+av7he+1vnmKelT2J4hSF+SN/aImk9yubW7Dt1FFQmCjXF+ve5RYCXesU2os7PMANk
 jPiYOCnbJMpHfwgXn97ULA1glZmJUFZ0iV6GnjtQFI41sbFGuL+IyV0+CopBAqpTs2vbpnFiliw
 x0fd3CByW0RE3r90Uog==
X-Proofpoint-ORIG-GUID: a4FazPKC_ZoWxjOcWuNdGcDmXK5BqRaW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-23_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610230046
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sunil.laxminarasimha@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: sunilvl@oss.qualcomm.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 10:23=E2=80=AFAM Alistair Francis
<Alistair.Francis@wdc.com> wrote:
>
> On Thu, 2026-10-15 at 12:19 +0530, Sunil V L wrote:
> > Hi all,
> >
> > This series adds ACPI Processor Properties Topology Table (PPTT)
> > support to
> > the RISC-V virt machine. PPTT allows the guest to discover the
> > processor and
> > cache topology exposed by the machine, which is useful for making
> > better
> > scheduling and cache-management decisions.
> >
> > The implementation describes the RISC-V virt cache hierarchy with
> > separate
> > L1 instruction and data caches, followed by unified L2 and L3 caches.
> > It also
> > enables the corresponding cache and cluster properties in the machine
> > SMP
> > description and wires the generated PPTT into the existing ACPI table
> > build.
> >
> > Unlike ARM, RISC-V doesn't have a way to discover the Cache
> > topology from registers. Hence, I am hardcoding default values for
> > the
> > cache topology structures. These cache topology structures are added
> > in
> > virt.c itself so that a future series can add support for DT as well.
> > In
> > future, it can be enhanced to support vendor cpu/soc specific cache
> > information to override this default hardcoded cache details.
>
> Why not add a vendor cpu/soc specific one to a vendor board? That way
> it actually model hardware instead of just providing the guest some
> made up information.
>
Thanks for the feedback!

Just to make sure I understand your suggestion correctly: should we avoid
defining a hardcoded cache topology for the generic CPU on virt, and genera=
te
PPTT cache information only for CPU models that provide an appropriate cach=
e
hierarchy?

I can certainly omit the cache information for the generic CPU. The consequ=
ence
is that Drew's CBQRI series, which requires cache information, would need a
suitable CPU model before it can be used with virt. Drew, please share
your thoughts.

> I feel like you should describe why we want this somewhere in the
> series
>
Sure. Let me update the cover letter why PPTT support is required.

> >
> > The series also updates the bios-tables-test data and removes the
> > temporary
> > PPTT entry from the allowed-diff list. The generated table is 96
> > bytes and
> > describes the package, cluster, and processor hierarchy for the virt
> > machine.
> >
> > This work follows the discussion and earlier work shared here:
> > https://lists.gnu.org/archive/html/qemu-riscv/2024-01/msg00928.html
> >
> > I have retained the contribution from Sia Jee Heng and added his
> > Signed-off-by tag to the relevant patch.
> >
> > To enable cache structures in the PPTT, one should use similar to
> > below
> > command line option.
> >
> > -M virt,smp-cache.0.cache=3Dl1d,smp-cache.0.topology=3Dcore,smp-
> > cache.1.cache=3Dl1i,smp-cache.1.topology=3Dcore,smp-cache.2.cache=3Dl2,=
smp-
> > cache.2.topology=3Dcluster,smp-cache.3.cache=3Dl3,smp-
> > cache.3.topology=3Dsocket
>
> Obviously :P
>
> Let's at least add this to the virt machine docs so it's useful for
> someone.
>
Sure.

Thanks,
Sunil

