Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1908ECA5FFF
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:55:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xENL9-0003hf-46; Wed, 07 Oct 2026 04:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xEJpT-00013V-8j
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:04:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sunil.laxminarasimha@oss.qualcomm.com>)
 id 1xEJpR-0004pm-9H
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 01:04:34 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6974UNEL1457025
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 05:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=
 qcppdkim1; bh=c1rRqeyH4w0vKFb9+WC0eZ7nYzuws23d/YTa0al83UA=; b=FA
 ymzvjcxoMrJSSBtF3MdX3mU/3uCxindCHzcTIcQeaXvDyRJdcz6X6k9/TCTZQrEI
 B/w68fY3vZkbAm0+CHtczRxGIc016KVzsIGDCA74UknXKeCE3BrkV5mmW57i+3AC
 FtmvbH10nuQG6L5BvAXk62sWXH8J8jwpWQEUwTbs5HrTWyOpowjwNhG3rRBzZuYY
 rGGnuTVaImARsNEGF4X3zNy5Nw77nLp7732QMj7LAPlnujRH8yvmAeKS+lUERjuQ
 L0N0YHpibrC/Ca0YtKR/2rQh/MJ6U/IREXd2N+B1TxHmXT6NmiTP2atYZLo3eBvT
 9ALYtNDEIsAjgxAGm67w==
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h4y91kv9c-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 05:04:26 +0000 (GMT)
Received: by mail-yx1-f70.google.com with SMTP id
 956f58d0204a3-67686ccd1b6so5094966d50.2
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 22:04:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791349466; cv=none;
 d=google.com; s=arc-20260327;
 b=oD2wV4HPNjEFDF6IKU+E+Z7W/hoX696+T/n8ggfMsHCdPX8ZwRncJ7pnvqoJhTgq3s
 hM0J527/eWDWCIt1BuaX5jUFQTV+L9cty02jHj+NXMR9FClvOmxKONvYdt489+POZrIH
 LLuyRPL+ptcwdFIFSvbEQ8SbmphH/hr+NOewIlTiirtENxktsBAoZ6Apun+oI7Ii/9n/
 OH/VWUOqeay5ia4ESwNFuFpvJIq/ibgg40qMJlLWNro3oqSixNX5IqX42thsJTPeb9bP
 M0LOO8V3FmSv5tFInAXlU87sukihtq1smDm7urXmowdx8YnmIu+1s/9VcY+uM+9TEq19
 7qXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=c1rRqeyH4w0vKFb9+WC0eZ7nYzuws23d/YTa0al83UA=;
 fh=BliICwT1X/0Es6yAdbF2LLdMhshdTNpqqAm3Rjr210E=;
 b=af/ms9Ggmrwapej8Sr55vOhWEZ87tw5yPq661VHTbP6rICjdscplqQgpiUNLDYZIkh
 7xbhCA++Dg7nH9qGkjfKT3wRFfOwsPJOE1TbFwBnykYDed4k5KldwE4al6qgbOd1GtUa
 p4cgaH0q6tWHoMJ1Oz2UpGDLGuvjWp8Aucx8fCTjOUr8FcMbHIlSRES6TWJGDueAyr//
 Sq0aHegO99P/tsTLMQvHZLgv43JvFKKV5u5jKo6qD+QiAZGZilVlrXU0Ld5+AbJJpe1n
 BjYxf+dQ/LEjg4rIbnrZkcAsUdQ/W4A+eprwdbmYlEbKmNE6fw7Xuxr/7N9F4YLeIqUV
 8x4w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791349466; x=1791954266; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=c1rRqeyH4w0vKFb9+WC0eZ7nYzuws23d/YTa0al83UA=;
 b=jqn+LlSujHLFPSoAnyTNrY7LNxBfGL0GSqeGi5eGhec3Nl5v2/kXQSncD3YdBjV5KL
 VX1QUTpVpb8mKjDk/WTT1K0+WEOj8LBcVG6WqnW4fhoRqBxEc1g5b2CO6RYXDit0O9dB
 BWO92DTThbkRF6bkZOqbZhBZQYjDtJ4/bYApNqgLTJwUFvKyrePsBAVsEC3sDSvALE6L
 bTfY7vQTywRIb2/GaR9SsR0UFEOps1s/3MGsbRdZ5EmmlkoktMi29QtIHF1mr+u+l19u
 5WKShuvew6CHPEo9imTeZNXldrZi2Fb+Yt5UWRMUOcI0mJiQjmaQ4j67gVeaA6Lmmf+s
 6W1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791349466; x=1791954266;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=c1rRqeyH4w0vKFb9+WC0eZ7nYzuws23d/YTa0al83UA=;
 b=z+qXstJf0YOovG0YImuz3lWzmicEtOHfxr7x3deD2vD0PdXhBBvwra+AVQ8sPy4wml
 DjTnX/CMe2PvRwhHlzHj46wqpF2PmliI4h+xAS++d5KlJ2RDk16g6FDu0uAE+DzbIYzm
 dSHZy/rlJBqa08TeTCzQH2L/FoYUMM2PyuDpWAtj2dT8zv+QGryPxWv6UZ7XMuz++9X/
 /FU/Umo6+5yf38ifo5TzjhvKUGSk1kqLmcPXa82OswARWFQMW2OZ5dXk/5L6zEDlXSaG
 hdgxoA7ctPOFwPrWO3XgiEYbefddAmAEPrBNapPcPnjYKCJO4++xfP2NjOlsg4R8CaiE
 acKA==
X-Gm-Message-State: AFq9FYL7C0DKxh+6W+PYPk9Sgagu+M1DS+/4jZfGpCkyQZem0KMv64Us
 mA7CR75m3aR1hINCDI05k+FRdw+v5MSfjHEjEeq9OwxRsZHArQS9PlzwkIYb4PkE0qLWOecVe7C
 bnJbe+/zU85c1Nt7aJXkmn1DH8G6OeNDiCre/VzKeKsWDByJ0UV+n1t7irNcZi1byaOWBhnfkik
 PR30oovk014E2Ybmoj6WVhZoMfBAsJH8D3
X-Gm-Gg: AYBFou15TRXBUEgLIt/o0xhKlwaEMi4/uZVUYy35dxUBqrq/nO5FHQsTrAvbGVAVW06
 Qlv/UUMyeXHGecBEIlOxDsZ0wczkCFUZ3kUp42k0pk0zVV9kG98Rjg6VXRkl88Q16RWA/XqWT20
 L29gB0RzQJmuryFByCbAF9138/wJ1o3FNXWv9F3irNlr9GtEtrqFBXmZG2/Q==
X-Received: by 2002:a05:690e:4808:b0:677:d6b1:d993 with SMTP id
 956f58d0204a3-6790a061729mr562000d50.47.1791349465696; 
 Tue, 06 Oct 2026 22:04:25 -0700 (PDT)
X-Received: by 2002:a05:690e:4808:b0:677:d6b1:d993 with SMTP id
 956f58d0204a3-6790a061729mr561997d50.47.1791349465281; Tue, 06 Oct 2026
 22:04:25 -0700 (PDT)
MIME-Version: 1.0
References: <20261005104008.214588-1-rick@sloservers.com>
In-Reply-To: <20261005104008.214588-1-rick@sloservers.com>
From: Sunil V L <sunilvl@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 10:34:14 +0530
X-Gm-Features: AclHuK9JAPzZ6hSQKUmB7VNqa6_iZP9uHR93vpDxJ3KPpqQ9dSBMR3wZebz221E
Message-ID: <CAB19ukGxy1ZQpU-HfNaEfcUcQ0e-=OiuR8NcJN5d0pmAg0d=FA@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] hw/riscv/virt: Fix the UART register width in SPCR
To: Rick Richard <rick@sloservers.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Sunil V L <sunilvl@ventanamicro.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDAxOSBTYWx0ZWRfX5XrR73lYMY/b
 m9XjelSwtKbooq8vZ6JKqH4HRLZtOQrpGb726vgBVGlV1OaXolckBEW1fjk/tzskKK6eA436QrW
 E+bVTDPkusjq+VSTwSzDSyDLK1m4QHs=
X-Authority-Analysis: v=2.4 cv=Ho/jiETS c=1 sm=1 tr=0 ts=6ac5d2da cx=c_pps
 a=S/uc88zpIJVNbziUnJ6G4Q==:117 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=F-tV29oOAAAA:8 a=EUspDBNiAAAA:8
 a=t6KeD4UUR2y4snKxGncA:9 a=QEXdDO2ut3YA:10 a=nd2WpGr1bMy9NW-iytEl:22
 a=Y2dezMJzicAI2PZykhZh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDAxOSBTYWx0ZWRfX0kCZ4naQ43Bp
 SuOm2FT3OGo2kEwBpyh7vQE+2mFo6WuwygcTddLLwUcHfS9HRXiiAvcztlIj9f7Zv0LaEdHeU5p
 rjQ63bLs8Lt2K7mUPg0jcMNcBgyq7OeS1qi3PMwWjaCOPyKBi3ID51R6is9huel4YEf4TEc5+YM
 HJcgcfv9KNfxid4MtwwoHFiP0e2mBSzOimuDlAOvW8lwNjcmBwILQCPgt9Z3TtjoYyqk2na4YlU
 qUkYjv/UpaolvV3ISJfg8nYcLFJkev8k9EI+k7YKwZaBGCUIWniHcNupeynJDdfffiuHe56ubwx
 Ja/Md5AddBKYC/FxrI/Xx8KjokftftAfYakmQ6c4/bjE4LuLlRZ4H8E6oCSk9MpJUALva/wa2Eg
 LXZe2MFv0DDwwwAYhwYpGwto2VUbLZafH6xhAgMRgv3dri0krRFueDGAoCnlxk1nXdKEj8oHQns
 WDjlfuOjfbQj2etpJlw==
X-Proofpoint-ORIG-GUID: wUVY6jW3ztjJxvPik5xPb0HVlFfvBaK-
X-Proofpoint-GUID: wUVY6jW3ztjJxvPik5xPb0HVlFfvBaK-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_02,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 adultscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070019
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

On Mon, Oct 5, 2026 at 4:11=E2=80=AFPM Rick Richard <rick@sloservers.com> w=
rote:
>
> The riscv virt board's SPCR table says its 16550 UART has a 32-bit
> register stride, but the registers are actually byte spaced.  Linux
> doesn't use this field to work out the register spacing, but FreeBSD's
> EFI loader does, and the FreeBSD kernel then crashes on the console
> UART when booted through EDK2 with ACPI enabled.
>
> This series fixes the width, plus the usual bios-tables-test patches to
> update the golden reference so 'make check' keeps passing.
>
> v2:
> - Keep the relative file path in the patch 3 iasl diff (Daniel)
> - Add Reviewed-by tags
>
> Thanks,
> Rick
>
> Rick Richard (3):
>   tests/qtest/bios-tables-test: Allow changes to riscv64 virt SPCR
>   hw/riscv/virt-acpi-build: Fix the UART register width in SPCR
>   tests/qtest/bios-tables-test: Update riscv64 virt SPCR golden
>     reference
>
>  hw/riscv/virt-acpi-build.c        |   2 +-
>  tests/data/acpi/riscv64/virt/SPCR | Bin 90 -> 90 bytes
>  2 files changed, 1 insertion(+), 1 deletion(-)
>
> --
> 2.43.0
>

Thanks for the fix!. Looks good to me.

For the series,
Reviewed-by: Sunil V L <sunilvl@oss.qualcomm.com>

