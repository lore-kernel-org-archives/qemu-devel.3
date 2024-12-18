Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 779BDE77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 15:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNvfk-0003Yf-Dg; Wed, 18 Dec 2024 10:09:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tNvfe-0003Xw-Bg
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:09:07 -0500
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <lists@philjordan.eu>)
 id 1tNvfY-0000p8-UL
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 10:09:06 -0500
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-725ed193c9eso5765100b3a.1
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 07:08:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1734534536; x=1735139336;
 darn=nongnu.org; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=cF2BiGZ4XG/tR8VYivUzcSbTC/+iHsy27iJPbiqS8ng=;
 b=VKpLPGJbfU2ulzd+WgBEBjzBkNTQSxF/PpYJhNArfmElv/N5BwEzbdvD6LDvfBG2mO
 gA/y1Hca4gX4UNiE1tujMXv0ZPN+WUyhthhg0jFs563D8LV41N7T353+bpHIh4aK5LOn
 6mGpAsCCuXcAzwDrBya2pWBBM+hm2CTS/c25QRp0eelIqSj2+osmRHPzsPR/aNI/E427
 +0/zIVxRG5p396i0Zd0Gpc3DJhlZXlHOuSBc+0DI4s64w7CC4k3USDLyO3z797qfYsJt
 jHxuHESvmGIjteopeYddHrrbzYCWXQnoazcMFhd3NviiCNX1Cfr1obbPEP+eSt6SSUUv
 CI3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734534536; x=1735139336;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cF2BiGZ4XG/tR8VYivUzcSbTC/+iHsy27iJPbiqS8ng=;
 b=cQGHC3HU75Rk09GVHox+FHiQfd2jMf0ebzqzpVp/wsXseQZbIAZVpKkbCgbX4839wj
 uNg5rx3aOZ7RDX1oIbVVRTPUPwdrZ+bhQm3O6KA9flcPvDyYJYrGOg85+jBrObVl18Hr
 inSF0X69xFEknUPL9+qb3ylfCTM0CgRTq3YlxkW/hp5f4ssXWs1rMBBim3KvVxH+aATn
 HDIj4NR46yTNkAqASf1mDfQFSdvvtEPZLU6hdfNkG0DcGj9NRrcoBYV4EdR957uF1QS8
 W0TU9ue7YxDgicQCmfdW7PekGRoQ/ofmaDzgUYfUgKzUtU25RP30ZCMlCvSdbO7o8GG4
 DgiA==
X-Gm-Message-State: AOJu0Ywn7VU8THf0M5d2ReUq1DWBXQITft9AKKX4Lmba6zL7dq8k67NZ
 +W6rXyHIh6DW4qNUKR+I5aABbk7hV/2jY0wDBen/9Oun/nIVvMY8AGNAI53UuR/NpD/KD5aLv0T
 Y2Q1z4YM346fVKLDvtqxaL4WV9tixzi3nxraT
X-Gm-Gg: ASbGncsSdyYv2GiheD+igaVYpmySxBvGII1EAejTfEa0mqqcxzJnFED80ifOIbvIMrp
 GoZvNdj64Qu7Z334ENzIKBm0aAqEAliSQ+FUSPQ==
X-Google-Smtp-Source: AGHT+IHJsJ/E44jTA0kozPDEyv08uYdPZF0jK7Rybn3Z65PgkZf0TXLyLLt9AV/zVuDiNlgAdTFmp4FVCNq8yZwfW94=
X-Received: by 2002:a17:90b:5203:b0:2ea:356f:51b4 with SMTP id
 98e67ed59e1d1-2f2e91ddd13mr4371676a91.13.1734534536196; Wed, 18 Dec 2024
 07:08:56 -0800 (PST)
MIME-Version: 1.0
References: <20241212083502.1439033-1-npiggin@gmail.com>
 <20241212083502.1439033-6-npiggin@gmail.com>
In-Reply-To: <20241212083502.1439033-6-npiggin@gmail.com>
From: Phil Dennis-Jordan <lists@philjordan.eu>
Date: Wed, 18 Dec 2024 16:08:45 +0100
Message-ID: <CAGCz3vuUoRPk1UN2+_SqLtn_q5qu-RM7kmwTgNeRM2Mf75hoeg@mail.gmail.com>
Subject: Re: [PATCH 5/8] hw/usb/xhci: Move HCD constants to a header and add
 register constants
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Content-Type: multipart/alternative; boundary="000000000000e1968d06298cca00"
Received-SPF: neutral client-ip=2607:f8b0:4864:20::42c;
 envelope-from=lists@philjordan.eu; helo=mail-pf1-x42c.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_NEUTRAL=0.779 autolearn=no autolearn_force=no
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

--000000000000e1968d06298cca00
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This looks sensible to me overall.

For the new symbolic constants for MMIO register offsets such as
XHCI_OPER_*, XHCI_INTR_* and so on, I'm wondering if it would be clearer to
give them all an _OFFSET suffix. It's not perfectly consistent to do so
across the code base, but quite a few device types do follow that
convention. In my opinion it improves readability, especially in the header
file, where these offset constants are frequently mixed in with constant
values that can be written to or read from these registers.

I think I also found a regression, and there's a couple other comments on
stylistic matters inline:

On Thu, 12 Dec 2024 at 09:37, Nicholas Piggin <npiggin@gmail.com> wrote:

> Prepare to use some of these constants in xhci qtest code.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/usb/hcd-xhci.h | 190 +++++++++++++++++++++++++++++++
>  hw/usb/hcd-xhci.c | 283 ++++++++++------------------------------------
>  2 files changed, 250 insertions(+), 223 deletions(-)
>
> diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h
> index fe16d7ad055..5781542f40e 100644
> --- a/hw/usb/hcd-xhci.h
> +++ b/hw/usb/hcd-xhci.h
> @@ -115,6 +115,196 @@ typedef enum TRBCCode {
>      CC_SPLIT_TRANSACTION_ERROR
>  } TRBCCode;
>
> +/* Register definitions */
> +#define XHCI_HCCAP_CAPLENGTH     0x00
> +#define XHCI_HCCAP_HCIVERSION    0x02
> +#define XHCI_HCCAP_HCSPARAMS1    0x04
> +#define XHCI_HCCAP_HCSPARAMS2    0x08
> +#define XHCI_HCCAP_HCSPARAMS3    0x0C
> +#define XHCI_HCCAP_HCCPARAMS1    0x10
> +#define XHCI_HCCAP_DBOFF         0x14
> +#define XHCI_HCCAP_RTSOFF        0x18
> +#define XHCI_HCCAP_HCCPARAMS2    0x1C
> +#define XHCI_HCCAP_EXTCAP_START  0x20 /* SW-defined */
> +
> +#define XHCI_PORT_PORTSC         0x00
> +#define   PORTSC_CCS             (1 << 0)
> +#define   PORTSC_PED             (1 << 1)
> +#define   PORTSC_OCA             (1 << 3)
> +#define   PORTSC_PR              (1 << 4)
> +#define   PORTSC_PLS_SHIFT           5
> +#define   PORTSC_PLS_MASK        0xf
> +#define   PORTSC_PP              (1 << 9)
> +#define   PORTSC_SPEED_SHIFT        10
> +#define   PORTSC_SPEED_MASK      0xf
> +#define   PORTSC_SPEED_FULL      (1 << 10)
> +#define   PORTSC_SPEED_LOW       (2 << 10)
> +#define   PORTSC_SPEED_HIGH      (3 << 10)
> +#define   PORTSC_SPEED_SUPER     (4 << 10)
> +#define   PORTSC_PIC_SHIFT          14
> +#define   PORTSC_PIC_MASK        0x3
> +#define   PORTSC_LWS             (1 << 16)
> +#define   PORTSC_CSC             (1 << 17)
> +#define   PORTSC_PEC             (1 << 18)
> +#define   PORTSC_WRC             (1 << 19)
> +#define   PORTSC_OCC             (1 << 20)
> +#define   PORTSC_PRC             (1 << 21)
> +#define   PORTSC_PLC             (1 << 22)
> +#define   PORTSC_CEC             (1 << 23)
> +#define   PORTSC_CAS             (1 << 24)
> +#define   PORTSC_WCE             (1 << 25)
> +#define   PORTSC_WDE             (1 << 26)
> +#define   PORTSC_WOE             (1 << 27)
> +#define   PORTSC_DR              (1 << 30)
> +#define   PORTSC_WPR             (1 << 31)
> +#define XHCI_PORT_PORTPMSC       0x04
> +#define XHCI_PORT_PORTLI         0x08
> +#define XHCI_PORT_PORTHLPMC      0x0C
> +
> +#define XHCI_OPER_USBCMD         0x00
> +#define   USBCMD_RS              (1 << 0)
> +#define   USBCMD_HCRST           (1 << 1)
> +#define   USBCMD_INTE            (1 << 2)
> +#define   USBCMD_HSEE            (1 << 3)
> +#define   USBCMD_LHCRST          (1 << 7)
> +#define   USBCMD_CSS             (1 << 8)
> +#define   USBCMD_CRS             (1 << 9)
> +#define   USBCMD_EWE             (1 << 10)
> +#define   USBCMD_EU3S            (1 << 11)
> +#define XHCI_OPER_USBSTS         0x04
> +#define   USBSTS_HCH             (1 << 0)
> +#define   USBSTS_HSE             (1 << 2)
> +#define   USBSTS_EINT            (1 << 3)
> +#define   USBSTS_PCD             (1 << 4)
> +#define   USBSTS_SSS             (1 << 8)
> +#define   USBSTS_RSS             (1 << 9)
> +#define   USBSTS_SRE             (1 << 10)
> +#define   USBSTS_CNR             (1 << 11)
> +#define   USBSTS_HCE             (1 << 12)
> +#define XHCI_OPER_PAGESIZE       0x08
> +#define XHCI_OPER_DNCTRL         0x14
> +#define XHCI_OPER_CRCR_LO        0x18
> +#define   CRCR_RCS              (1 << 0)
> +#define   CRCR_CS               (1 << 1)
> +#define   CRCR_CA               (1 << 2)
> +#define   CRCR_CRR              (1 << 3)
> +#define XHCI_OPER_CRCR_HI        0x1C
> +#define XHCI_OPER_DCBAAP_LO      0x30
> +#define XHCI_OPER_DCBAAP_HI      0x34
> +#define XHCI_OPER_CONFIG         0x38
> +
> +#define XHCI_OPER_MFINDEX        0x00
> +#define XHCI_OPER_IR0            0x20
> +#define XHCI_OPER_IR_SZ          0x20
> +
> +#define XHCI_INTR_IMAN           0x00
> +#define   IMAN_IP                (1 << 0)
> +#define   IMAN_IE                (1 << 1)
> +#define XHCI_INTR_IMOD           0x04
> +#define XHCI_INTR_ERSTSZ         0x08
> +#define XHCI_INTR_ERSTBA_LO      0x10
> +#define XHCI_INTR_ERSTBA_HI      0x14
> +#define XHCI_INTR_ERDP_LO        0x18
> +#define   ERDP_EHB               (1 << 3)
> +#define XHCI_INTR_ERDP_HI        0x1C
> +
> +#define TRB_SIZE 16
> +typedef struct XHCITRB {
> +    uint64_t parameter;
> +    uint32_t status;
> +    uint32_t control;
> +    dma_addr_t addr;
> +    bool ccs;
> +} XHCITRB;
> +
> +enum {
> +    PLS_U0              =3D  0,
> +    PLS_U1              =3D  1,
> +    PLS_U2              =3D  2,
> +    PLS_U3              =3D  3,
> +    PLS_DISABLED        =3D  4,
> +    PLS_RX_DETECT       =3D  5,
> +    PLS_INACTIVE        =3D  6,
> +    PLS_POLLING         =3D  7,
> +    PLS_RECOVERY        =3D  8,
> +    PLS_HOT_RESET       =3D  9,
> +    PLS_COMPILANCE_MODE =3D 10,
> +    PLS_TEST_MODE       =3D 11,
> +    PLS_RESUME          =3D 15,
> +};
> +
> +#define CR_LINK TR_LINK
> +
> +#define TRB_C               (1 << 0)
> +#define TRB_TYPE_SHIFT          10
> +#define TRB_TYPE_MASK       0x3f
> +#define TRB_TYPE(t)         (((t).control >> TRB_TYPE_SHIFT) &
> TRB_TYPE_MASK)
> +
> +#define TRB_EV_ED           (1 << 2)
> +
> +#define TRB_TR_ENT          (1 << 1)
> +#define TRB_TR_ISP          (1 << 2)
> +#define TRB_TR_NS           (1 << 3)
> +#define TRB_TR_CH           (1 << 4)
> +#define TRB_TR_IOC          (1 << 5)
> +#define TRB_TR_IDT          (1 << 6)
> +#define TRB_TR_TBC_SHIFT        7
> +#define TRB_TR_TBC_MASK     0x3
> +#define TRB_TR_BEI          (1 << 9)
> +#define TRB_TR_TLBPC_SHIFT      16
> +#define TRB_TR_TLBPC_MASK   0xf
> +#define TRB_TR_FRAMEID_SHIFT    20
> +#define TRB_TR_FRAMEID_MASK 0x7ff
> +#define TRB_TR_SIA          (1 << 31)
> +
> +#define TRB_TR_DIR          (1 << 16)
> +
> +#define TRB_CR_SLOTID_SHIFT     24
> +#define TRB_CR_SLOTID_MASK  0xff
> +#define TRB_CR_EPID_SHIFT       16
> +#define TRB_CR_EPID_MASK    0x1f
> +
> +#define TRB_CR_BSR          (1 << 9)
> +#define TRB_CR_DC           (1 << 9)
> +
> +#define TRB_LK_TC           (1 << 1)
> +
> +#define TRB_INTR_SHIFT          22
> +#define TRB_INTR_MASK       0x3ff
> +#define TRB_INTR(t)         (((t).status >> TRB_INTR_SHIFT) &
> TRB_INTR_MASK)
> +
> +#define EP_TYPE_MASK        0x7
> +#define EP_TYPE_SHIFT           3
> +
> +#define EP_STATE_MASK       0x7
> +#define EP_DISABLED         (0 << 0)
> +#define EP_RUNNING          (1 << 0)
> +#define EP_HALTED           (2 << 0)
> +#define EP_STOPPED          (3 << 0)
> +#define EP_ERROR            (4 << 0)
> +
> +#define SLOT_STATE_MASK     0x1f
> +#define SLOT_STATE_SHIFT        27
> +#define SLOT_STATE(s)       (((s) >> SLOT_STATE_SHIFT) & SLOT_STATE_MASK=
)
> +#define SLOT_ENABLED        0
> +#define SLOT_DEFAULT        1
> +#define SLOT_ADDRESSED      2
> +#define SLOT_CONFIGURED     3
> +
> +#define SLOT_CONTEXT_ENTRIES_MASK 0x1f
> +#define SLOT_CONTEXT_ENTRIES_SHIFT 27
> +
> +typedef enum EPType {
> +    ET_INVALID =3D 0,
> +    ET_ISO_OUT,
> +    ET_BULK_OUT,
> +    ET_INTR_OUT,
> +    ET_CONTROL,
> +    ET_ISO_IN,
> +    ET_BULK_IN,
> +    ET_INTR_IN,
> +} EPType;
> +
>  typedef struct XHCIRing {
>      dma_addr_t dequeue;
>      bool ccs;
> diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c
> index d85adaca0dc..df0421ec326 100644
> --- a/hw/usb/hcd-xhci.c
> +++ b/hw/usb/hcd-xhci.c
> @@ -65,154 +65,6 @@
>  # error Increase XHCI_LEN_REGS
>  #endif
>
> -/* bit definitions */
> -#define USBCMD_RS       (1<<0)
> -#define USBCMD_HCRST    (1<<1)
> -#define USBCMD_INTE     (1<<2)
> -#define USBCMD_HSEE     (1<<3)
> -#define USBCMD_LHCRST   (1<<7)
> -#define USBCMD_CSS      (1<<8)
> -#define USBCMD_CRS      (1<<9)
> -#define USBCMD_EWE      (1<<10)
> -#define USBCMD_EU3S     (1<<11)
> -
> -#define USBSTS_HCH      (1<<0)
> -#define USBSTS_HSE      (1<<2)
> -#define USBSTS_EINT     (1<<3)
> -#define USBSTS_PCD      (1<<4)
> -#define USBSTS_SSS      (1<<8)
> -#define USBSTS_RSS      (1<<9)
> -#define USBSTS_SRE      (1<<10)
> -#define USBSTS_CNR      (1<<11)
> -#define USBSTS_HCE      (1<<12)
> -
> -
> -#define PORTSC_CCS          (1<<0)
> -#define PORTSC_PED          (1<<1)
> -#define PORTSC_OCA          (1<<3)
> -#define PORTSC_PR           (1<<4)
> -#define PORTSC_PLS_SHIFT        5
> -#define PORTSC_PLS_MASK     0xf
> -#define PORTSC_PP           (1<<9)
> -#define PORTSC_SPEED_SHIFT      10
> -#define PORTSC_SPEED_MASK   0xf
> -#define PORTSC_SPEED_FULL   (1<<10)
> -#define PORTSC_SPEED_LOW    (2<<10)
> -#define PORTSC_SPEED_HIGH   (3<<10)
> -#define PORTSC_SPEED_SUPER  (4<<10)
> -#define PORTSC_PIC_SHIFT        14
> -#define PORTSC_PIC_MASK     0x3
> -#define PORTSC_LWS          (1<<16)
> -#define PORTSC_CSC          (1<<17)
> -#define PORTSC_PEC          (1<<18)
> -#define PORTSC_WRC          (1<<19)
> -#define PORTSC_OCC          (1<<20)
> -#define PORTSC_PRC          (1<<21)
> -#define PORTSC_PLC          (1<<22)
> -#define PORTSC_CEC          (1<<23)
> -#define PORTSC_CAS          (1<<24)
> -#define PORTSC_WCE          (1<<25)
> -#define PORTSC_WDE          (1<<26)
> -#define PORTSC_WOE          (1<<27)
> -#define PORTSC_DR           (1<<30)
> -#define PORTSC_WPR          (1<<31)
> -
> -#define CRCR_RCS        (1<<0)
> -#define CRCR_CS         (1<<1)
> -#define CRCR_CA         (1<<2)
> -#define CRCR_CRR        (1<<3)
> -
> -#define IMAN_IP         (1<<0)
> -#define IMAN_IE         (1<<1)
> -
> -#define ERDP_EHB        (1<<3)
> -
> -#define TRB_SIZE 16
> -typedef struct XHCITRB {
> -    uint64_t parameter;
> -    uint32_t status;
> -    uint32_t control;
> -    dma_addr_t addr;
> -    bool ccs;
> -} XHCITRB;
> -
> -enum {
> -    PLS_U0              =3D  0,
> -    PLS_U1              =3D  1,
> -    PLS_U2              =3D  2,
> -    PLS_U3              =3D  3,
> -    PLS_DISABLED        =3D  4,
> -    PLS_RX_DETECT       =3D  5,
> -    PLS_INACTIVE        =3D  6,
> -    PLS_POLLING         =3D  7,
> -    PLS_RECOVERY        =3D  8,
> -    PLS_HOT_RESET       =3D  9,
> -    PLS_COMPILANCE_MODE =3D 10,
> -    PLS_TEST_MODE       =3D 11,
> -    PLS_RESUME          =3D 15,
> -};
> -
> -#define CR_LINK TR_LINK
> -
> -#define TRB_C               (1<<0)
> -#define TRB_TYPE_SHIFT          10
> -#define TRB_TYPE_MASK       0x3f
> -#define TRB_TYPE(t)         (((t).control >> TRB_TYPE_SHIFT) &
> TRB_TYPE_MASK)
> -
> -#define TRB_EV_ED           (1<<2)
> -
> -#define TRB_TR_ENT          (1<<1)
> -#define TRB_TR_ISP          (1<<2)
> -#define TRB_TR_NS           (1<<3)
> -#define TRB_TR_CH           (1<<4)
> -#define TRB_TR_IOC          (1<<5)
> -#define TRB_TR_IDT          (1<<6)
> -#define TRB_TR_TBC_SHIFT        7
> -#define TRB_TR_TBC_MASK     0x3
> -#define TRB_TR_BEI          (1<<9)
> -#define TRB_TR_TLBPC_SHIFT      16
> -#define TRB_TR_TLBPC_MASK   0xf
> -#define TRB_TR_FRAMEID_SHIFT    20
> -#define TRB_TR_FRAMEID_MASK 0x7ff
> -#define TRB_TR_SIA          (1<<31)
> -
> -#define TRB_TR_DIR          (1<<16)
> -
> -#define TRB_CR_SLOTID_SHIFT     24
> -#define TRB_CR_SLOTID_MASK  0xff
> -#define TRB_CR_EPID_SHIFT       16
> -#define TRB_CR_EPID_MASK    0x1f
> -
> -#define TRB_CR_BSR          (1<<9)
> -#define TRB_CR_DC           (1<<9)
> -
> -#define TRB_LK_TC           (1<<1)
> -
> -#define TRB_INTR_SHIFT          22
> -#define TRB_INTR_MASK       0x3ff
> -#define TRB_INTR(t)         (((t).status >> TRB_INTR_SHIFT) &
> TRB_INTR_MASK)
> -
> -#define EP_TYPE_MASK        0x7
> -#define EP_TYPE_SHIFT           3
> -
> -#define EP_STATE_MASK       0x7
> -#define EP_DISABLED         (0<<0)
> -#define EP_RUNNING          (1<<0)
> -#define EP_HALTED           (2<<0)
> -#define EP_STOPPED          (3<<0)
> -#define EP_ERROR            (4<<0)
> -
> -#define SLOT_STATE_MASK     0x1f
> -#define SLOT_STATE_SHIFT        27
> -#define SLOT_STATE(s)       (((s)>>SLOT_STATE_SHIFT)&SLOT_STATE_MASK)
> -#define SLOT_ENABLED        0
> -#define SLOT_DEFAULT        1
> -#define SLOT_ADDRESSED      2
> -#define SLOT_CONFIGURED     3
> -
> -#define SLOT_CONTEXT_ENTRIES_MASK 0x1f
> -#define SLOT_CONTEXT_ENTRIES_SHIFT 27
> -
>  #define get_field(data, field)                  \
>      (((data) >> field##_SHIFT) & field##_MASK)
>
> @@ -223,17 +75,6 @@ enum {
>          *data =3D val_;                                           \
>      } while (0)
>
> -typedef enum EPType {
> -    ET_INVALID =3D 0,
> -    ET_ISO_OUT,
> -    ET_BULK_OUT,
> -    ET_INTR_OUT,
> -    ET_CONTROL,
> -    ET_ISO_IN,
> -    ET_BULK_IN,
> -    ET_INTR_IN,
> -} EPType;
> -
>  typedef struct XHCITransfer {
>      XHCIEPContext *epctx;
>      USBPacket packet;
> @@ -2736,56 +2577,55 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr
> reg, unsigned size)
>      uint32_t ret;
>
>      switch (reg) {
> -    case 0x00: /* HCIVERSION, CAPLENGTH */
> +    case XHCI_HCCAP_CAPLENGTH: /* Covers HCIVERSION and CAPLENGTH */
>          ret =3D 0x01000000 | LEN_CAP;
>          break;
> -    case 0x04: /* HCSPARAMS 1 */
> +    case XHCI_HCCAP_HCSPARAMS1:
>          ret =3D ((xhci->numports_2+xhci->numports_3)<<24)
>              | (xhci->numintrs<<8) | xhci->numslots;
>          break;
> -    case 0x08: /* HCSPARAMS 2 */
> +    case XHCI_HCCAP_HCSPARAMS2:
>          ret =3D 0x0000000f;
>          break;
> -    case 0x0c: /* HCSPARAMS 3 */
> +    case XHCI_HCCAP_HCSPARAMS3:
>          ret =3D 0x00000000;
>          break;
> -    case 0x10: /* HCCPARAMS */
> -        if (sizeof(dma_addr_t) =3D=3D 4) {
> -            ret =3D 0x00080000 | (xhci->max_pstreams_mask << 12);
> -        } else {
> -            ret =3D 0x00080001 | (xhci->max_pstreams_mask << 12);
> +    case XHCI_HCCAP_HCCPARAMS1:
> +        ret =3D (XHCI_HCCAP_EXTCAP_START >> 2) | (xhci->max_pstreams_mas=
k
> << 12);
>

This doesn't look like it's equivalent to the original code. I think you
want
((XHCI_HCCAP_EXTCAP_START >> 2) << 16) | (xhci->max_pstreams_mask << 12);

That's=E2=80=A6 not particularly readable either though, so if we're going =
to break
up the magic numbers here, how about something like:

ret =3D (XHCI_HCCAP_EXTCAP_START / 4) << XHCI_HCCPARAM_EXTPTR_SHIFT;
ret |=3D xhci->max_pstreams_mask << XHCI_HCCPARAM_MAXPSASIZE_SHIFT;


> +        if (sizeof(dma_addr_t) =3D=3D 8) {
> +            ret |=3D 0x00000001; /* AC64 */
>

and then this can become
ret |=3D XHCI_HCCPARAM_AC64;

or something like that.

         }
>          break;
> -    case 0x14: /* DBOFF */
> +    case XHCI_HCCAP_DBOFF:
>          ret =3D OFF_DOORBELL;
>          break;
> -    case 0x18: /* RTSOFF */
> +    case XHCI_HCCAP_RTSOFF:
>          ret =3D OFF_RUNTIME;
>          break;
>
>      /* extended capabilities */
> -    case 0x20: /* Supported Protocol:00 */
> +    case XHCI_HCCAP_EXTCAP_START + 0x00: /* Supported Protocol:00 */
>          ret =3D 0x02000402; /* USB 2.0 */
>          break;
> -    case 0x24: /* Supported Protocol:04 */
> +    case XHCI_HCCAP_EXTCAP_START + 0x04: /* Supported Protocol:04 */
>          ret =3D 0x20425355; /* "USB " */
>          break;
> -    case 0x28: /* Supported Protocol:08 */
> +    case XHCI_HCCAP_EXTCAP_START + 0x08: /* Supported Protocol:08 */
>          ret =3D (xhci->numports_2 << 8) | (xhci->numports_3 + 1);
>          break;
> -    case 0x2c: /* Supported Protocol:0c */
> +    case XHCI_HCCAP_EXTCAP_START + 0x0c: /* Supported Protocol:0c */
>          ret =3D 0x00000000; /* reserved */
>          break;
> -    case 0x30: /* Supported Protocol:00 */
> +    case XHCI_HCCAP_EXTCAP_START + 0x10: /* Supported Protocol:00 */
>          ret =3D 0x03000002; /* USB 3.0 */
>          break;
> -    case 0x34: /* Supported Protocol:04 */
> +    case XHCI_HCCAP_EXTCAP_START + 0x14: /* Supported Protocol:04 */
>          ret =3D 0x20425355; /* "USB " */
>          break;
> -    case 0x38: /* Supported Protocol:08 */
> +    case XHCI_HCCAP_EXTCAP_START + 0x18: /* Supported Protocol:08 */
>          ret =3D (xhci->numports_3 << 8) | 1;
>          break;
> -    case 0x3c: /* Supported Protocol:0c */
> +    case XHCI_HCCAP_EXTCAP_START + 0x1c: /* Supported Protocol:0c */
>          ret =3D 0x00000000; /* reserved */
>          break;
>      default:
> @@ -2803,14 +2643,13 @@ static uint64_t xhci_port_read(void *ptr, hwaddr
> reg, unsigned size)
>      uint32_t ret;
>
>      switch (reg) {
> -    case 0x00: /* PORTSC */
> +    case XHCI_PORT_PORTSC:
>          ret =3D port->portsc;
>          break;
> -    case 0x04: /* PORTPMSC */
> -    case 0x08: /* PORTLI */
> +    case XHCI_PORT_PORTPMSC:
> +    case XHCI_PORT_PORTLI:
>          ret =3D 0;
>          break;
> -    case 0x0c: /* reserved */
>

I think it's worth keeping explicitly unhandled case labels documented like
this. (This one appears to be XHCI_PORT_PORTHLPMC nowadays, I assume it was
reserved in an earlier spec version.)

     default:
>          trace_usb_xhci_unimplemented("port read", reg);
>          ret =3D 0;
> @@ -2829,7 +2668,7 @@ static void xhci_port_write(void *ptr, hwaddr reg,
>      trace_usb_xhci_port_write(port->portnr, reg, val);
>
>      switch (reg) {
> -    case 0x00: /* PORTSC */
> +    case XHCI_PORT_PORTSC:
>          /* write-1-to-start bits */
>          if (val & PORTSC_WPR) {
>              xhci_port_reset(port, true);
> @@ -2880,8 +2719,6 @@ static void xhci_port_write(void *ptr, hwaddr reg,
>              xhci_port_notify(port, notify);
>          }
>          break;
> -    case 0x04: /* PORTPMSC */
> -    case 0x08: /* PORTLI */
>

Hmm. Looks like PORTLI is actually a read-only register, so writing this
ought to trigger a LOG_GUEST_ERROR. And I don't think it's a bad thing to
explicitly document PORTPMSC as unimplemented. (And I guess that ought to
be a LOG_UNIMP, not a trace, sigh.) The improved logging can be a separate
commit - in fact I don't mind tagging that fix onto my own pending XHCI
patch set, but I think for this commit we ought to keep the case labels
(with the new symbolic constants).


>      default:
>          trace_usb_xhci_unimplemented("port write", reg);
>      }
> @@ -2893,31 +2730,31 @@ static uint64_t xhci_oper_read(void *ptr, hwaddr
> reg, unsigned size)
>      uint32_t ret;
>
>      switch (reg) {
> -    case 0x00: /* USBCMD */
> +    case XHCI_OPER_USBCMD:
>          ret =3D xhci->usbcmd;
>          break;
> -    case 0x04: /* USBSTS */
> +    case XHCI_OPER_USBSTS:
>          ret =3D xhci->usbsts;
>          break;
> -    case 0x08: /* PAGESIZE */
> +    case XHCI_OPER_PAGESIZE:
>          ret =3D 1; /* 4KiB */
>          break;
> -    case 0x14: /* DNCTRL */
> +    case XHCI_OPER_DNCTRL:
>          ret =3D xhci->dnctrl;
>          break;
> -    case 0x18: /* CRCR low */
> +    case XHCI_OPER_CRCR_LO:
>          ret =3D xhci->crcr_low & ~0xe;
>          break;
> -    case 0x1c: /* CRCR high */
> +    case XHCI_OPER_CRCR_HI:
>          ret =3D xhci->crcr_high;
>          break;
> -    case 0x30: /* DCBAAP low */
> +    case XHCI_OPER_DCBAAP_LO:
>          ret =3D xhci->dcbaap_low;
>          break;
> -    case 0x34: /* DCBAAP high */
> +    case XHCI_OPER_DCBAAP_HI:
>          ret =3D xhci->dcbaap_high;
>          break;
> -    case 0x38: /* CONFIG */
> +    case XHCI_OPER_CONFIG:
>          ret =3D xhci->config;
>          break;
>      default:
> @@ -2937,7 +2774,7 @@ static void xhci_oper_write(void *ptr, hwaddr reg,
>      trace_usb_xhci_oper_write(reg, val);
>
>      switch (reg) {
> -    case 0x00: /* USBCMD */
> +    case XHCI_OPER_USBCMD:
>          if ((val & USBCMD_RS) && !(xhci->usbcmd & USBCMD_RS)) {
>              xhci_run(xhci);
>          } else if (!(val & USBCMD_RS) && (xhci->usbcmd & USBCMD_RS)) {
> @@ -2959,19 +2796,19 @@ static void xhci_oper_write(void *ptr, hwaddr reg=
,
>          xhci_intr_update(xhci, 0);
>          break;
>
> -    case 0x04: /* USBSTS */
> +    case XHCI_OPER_USBSTS:
>          /* these bits are write-1-to-clear */
>          xhci->usbsts &=3D ~(val &
> (USBSTS_HSE|USBSTS_EINT|USBSTS_PCD|USBSTS_SRE));
>          xhci_intr_update(xhci, 0);
>          break;
>
> -    case 0x14: /* DNCTRL */
> +    case XHCI_OPER_DNCTRL:
>          xhci->dnctrl =3D val & 0xffff;
>          break;
> -    case 0x18: /* CRCR low */
> +    case XHCI_OPER_CRCR_LO:
>          xhci->crcr_low =3D (val & 0xffffffcf) | (xhci->crcr_low & CRCR_C=
RR);
>          break;
> -    case 0x1c: /* CRCR high */
> +    case XHCI_OPER_CRCR_HI:
>          xhci->crcr_high =3D val;
>          if (xhci->crcr_low & (CRCR_CA|CRCR_CS) && (xhci->crcr_low &
> CRCR_CRR)) {
>              XHCIEvent event =3D {ER_COMMAND_COMPLETE,
> CC_COMMAND_RING_STOPPED};
> @@ -2984,13 +2821,13 @@ static void xhci_oper_write(void *ptr, hwaddr reg=
,
>          }
>          xhci->crcr_low &=3D ~(CRCR_CA | CRCR_CS);
>          break;
> -    case 0x30: /* DCBAAP low */
> +    case XHCI_OPER_DCBAAP_LO:
>          xhci->dcbaap_low =3D val & 0xffffffc0;
>          break;
> -    case 0x34: /* DCBAAP high */
> +    case XHCI_OPER_DCBAAP_HI:
>          xhci->dcbaap_high =3D val;
>          break;
> -    case 0x38: /* CONFIG */
> +    case XHCI_OPER_CONFIG:
>          xhci->config =3D val & 0xff;
>          break;
>      default:
> @@ -3004,9 +2841,9 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr
> reg,
>      XHCIState *xhci =3D ptr;
>      uint32_t ret =3D 0;
>
> -    if (reg < 0x20) {
> +    if (reg < XHCI_OPER_IR0) {
>          switch (reg) {
> -        case 0x00: /* MFINDEX */
> +        case XHCI_OPER_MFINDEX:
>              ret =3D xhci_mfindex_get(xhci) & 0x3fff;
>              break;
>          default:
> @@ -3014,28 +2851,28 @@ static uint64_t xhci_runtime_read(void *ptr,
> hwaddr reg,
>              break;
>          }
>      } else {
> -        int v =3D (reg - 0x20) / 0x20;
> +        int v =3D (reg - XHCI_OPER_IR0) / XHCI_OPER_IR_SZ;
>          XHCIInterrupter *intr =3D &xhci->intr[v];
> -        switch (reg & 0x1f) {
> -        case 0x00: /* IMAN */
> +        switch (reg & (XHCI_OPER_IR_SZ - 1)) {
> +        case XHCI_INTR_IMAN:
>              ret =3D intr->iman;
>              break;
> -        case 0x04: /* IMOD */
> +        case XHCI_INTR_IMOD:
>              ret =3D intr->imod;
>              break;
> -        case 0x08: /* ERSTSZ */
> +        case XHCI_INTR_ERSTSZ:
>              ret =3D intr->erstsz;
>              break;
> -        case 0x10: /* ERSTBA low */
> +        case XHCI_INTR_ERSTBA_LO:
>              ret =3D intr->erstba_low;
>              break;
> -        case 0x14: /* ERSTBA high */
> +        case XHCI_INTR_ERSTBA_HI:
>              ret =3D intr->erstba_high;
>              break;
> -        case 0x18: /* ERDP low */
> +        case XHCI_INTR_ERDP_LO:
>              ret =3D intr->erdp_low;
>              break;
> -        case 0x1c: /* ERDP high */
> +        case XHCI_INTR_ERDP_HI:
>              ret =3D intr->erdp_high;
>              break;
>          }
> @@ -3054,15 +2891,15 @@ static void xhci_runtime_write(void *ptr, hwaddr
> reg,
>
>      trace_usb_xhci_runtime_write(reg, val);
>
> -    if (reg < 0x20) {
> +    if (reg < XHCI_OPER_IR0) {
>          trace_usb_xhci_unimplemented("runtime write", reg);
>          return;
>      }
> -    v =3D (reg - 0x20) / 0x20;
> +    v =3D (reg - XHCI_OPER_IR0) / XHCI_OPER_IR_SZ;
>      intr =3D &xhci->intr[v];
>
> -    switch (reg & 0x1f) {
> -    case 0x00: /* IMAN */
> +    switch (reg & (XHCI_OPER_IR_SZ - 1)) {
> +    case XHCI_INTR_IMAN:
>          if (val & IMAN_IP) {
>              intr->iman &=3D ~IMAN_IP;
>          }
> @@ -3070,13 +2907,13 @@ static void xhci_runtime_write(void *ptr, hwaddr
> reg,
>          intr->iman |=3D val & IMAN_IE;
>          xhci_intr_update(xhci, v);
>          break;
> -    case 0x04: /* IMOD */
> +    case XHCI_INTR_IMOD:
>          intr->imod =3D val;
>          break;
> -    case 0x08: /* ERSTSZ */
> +    case XHCI_INTR_ERSTSZ:
>          intr->erstsz =3D val & 0xffff;
>          break;
> -    case 0x10: /* ERSTBA low */
> +    case XHCI_INTR_ERSTBA_LO:
>          if (xhci->nec_quirks) {
>              /* NEC driver bug: it doesn't align this to 64 bytes */
>              intr->erstba_low =3D val & 0xfffffff0;
> @@ -3084,11 +2921,11 @@ static void xhci_runtime_write(void *ptr, hwaddr
> reg,
>              intr->erstba_low =3D val & 0xffffffc0;
>          }
>          break;
> -    case 0x14: /* ERSTBA high */
> +    case XHCI_INTR_ERSTBA_HI:
>          intr->erstba_high =3D val;
>          xhci_er_reset(xhci, v);
>          break;
> -    case 0x18: /* ERDP low */
> +    case XHCI_INTR_ERDP_LO:
>          if (val & ERDP_EHB) {
>              intr->erdp_low &=3D ~ERDP_EHB;
>          }
> @@ -3103,7 +2940,7 @@ static void xhci_runtime_write(void *ptr, hwaddr re=
g,
>              }
>          }
>          break;
> -    case 0x1c: /* ERDP high */
> +    case XHCI_INTR_ERDP_HI:
>          intr->erdp_high =3D val;
>          break;
>      default:
> --
> 2.45.2
>
>
>

--000000000000e1968d06298cca00
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div>This looks sensible to me overall.</=
div><div><br></div><div>For the new symbolic constants for MMIO register of=
fsets such as XHCI_OPER_*, XHCI_INTR_* and so on, I&#39;m wondering if it w=
ould be clearer to give them all an _OFFSET suffix. It&#39;s not perfectly =
consistent to do so across the code base, but quite a few device types do f=
ollow that convention. In my opinion it improves readability, especially in=
 the header file, where these offset constants are frequently mixed in with=
 constant values that can be written to or read from these registers.</div>=
<div><br></div><div>I think I also found a regression, and there&#39;s a co=
uple other comments on stylistic matters inline:<br></div></div><br><div cl=
ass=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D"gmail_a=
ttr">On Thu, 12 Dec 2024 at 09:37, Nicholas Piggin &lt;<a href=3D"mailto:np=
iggin@gmail.com">npiggin@gmail.com</a>&gt; wrote:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">Prepare to use some of these constants in=
 xhci qtest code.<br>
<br>
Signed-off-by: Nicholas Piggin &lt;<a href=3D"mailto:npiggin@gmail.com" tar=
get=3D"_blank">npiggin@gmail.com</a>&gt;<br>
---<br>
=C2=A0hw/usb/hcd-xhci.h | 190 +++++++++++++++++++++++++++++++<br>
=C2=A0hw/usb/hcd-xhci.c | 283 ++++++++++-----------------------------------=
-<br>
=C2=A02 files changed, 250 insertions(+), 223 deletions(-)<br>
<br>
diff --git a/hw/usb/hcd-xhci.h b/hw/usb/hcd-xhci.h<br>
index fe16d7ad055..5781542f40e 100644<br>
--- a/hw/usb/hcd-xhci.h<br>
+++ b/hw/usb/hcd-xhci.h<br>
@@ -115,6 +115,196 @@ typedef enum TRBCCode {<br>
=C2=A0 =C2=A0 =C2=A0CC_SPLIT_TRANSACTION_ERROR<br>
=C2=A0} TRBCCode;<br>
<br>
+/* Register definitions */<br>
+#define XHCI_HCCAP_CAPLENGTH=C2=A0 =C2=A0 =C2=A00x00<br>
+#define XHCI_HCCAP_HCIVERSION=C2=A0 =C2=A0 0x02<br>
+#define XHCI_HCCAP_HCSPARAMS1=C2=A0 =C2=A0 0x04<br>
+#define XHCI_HCCAP_HCSPARAMS2=C2=A0 =C2=A0 0x08<br>
+#define XHCI_HCCAP_HCSPARAMS3=C2=A0 =C2=A0 0x0C<br>
+#define XHCI_HCCAP_HCCPARAMS1=C2=A0 =C2=A0 0x10<br>
+#define XHCI_HCCAP_DBOFF=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x14<br>
+#define XHCI_HCCAP_RTSOFF=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x18<br>
+#define XHCI_HCCAP_HCCPARAMS2=C2=A0 =C2=A0 0x1C<br>
+#define XHCI_HCCAP_EXTCAP_START=C2=A0 0x20 /* SW-defined */<br>
+<br>
+#define XHCI_PORT_PORTSC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00<br>
+#define=C2=A0 =C2=A0PORTSC_CCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 0)<br>
+#define=C2=A0 =C2=A0PORTSC_PED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 1)<br>
+#define=C2=A0 =C2=A0PORTSC_OCA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 3)<br>
+#define=C2=A0 =C2=A0PORTSC_PR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 4)<br>
+#define=C2=A0 =C2=A0PORTSC_PLS_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A05<br>
+#define=C2=A0 =C2=A0PORTSC_PLS_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0xf<br>
+#define=C2=A0 =C2=A0PORTSC_PP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 9)<br>
+#define=C2=A0 =C2=A0PORTSC_SPEED_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 10<br>
+#define=C2=A0 =C2=A0PORTSC_SPEED_MASK=C2=A0 =C2=A0 =C2=A0 0xf<br>
+#define=C2=A0 =C2=A0PORTSC_SPEED_FULL=C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 10)<=
br>
+#define=C2=A0 =C2=A0PORTSC_SPEED_LOW=C2=A0 =C2=A0 =C2=A0 =C2=A0(2 &lt;&lt;=
 10)<br>
+#define=C2=A0 =C2=A0PORTSC_SPEED_HIGH=C2=A0 =C2=A0 =C2=A0 (3 &lt;&lt; 10)<=
br>
+#define=C2=A0 =C2=A0PORTSC_SPEED_SUPER=C2=A0 =C2=A0 =C2=A0(4 &lt;&lt; 10)<=
br>
+#define=C2=A0 =C2=A0PORTSC_PIC_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 14<=
br>
+#define=C2=A0 =C2=A0PORTSC_PIC_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x3<br>
+#define=C2=A0 =C2=A0PORTSC_LWS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 16)<br>
+#define=C2=A0 =C2=A0PORTSC_CSC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 17)<br>
+#define=C2=A0 =C2=A0PORTSC_PEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 18)<br>
+#define=C2=A0 =C2=A0PORTSC_WRC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 19)<br>
+#define=C2=A0 =C2=A0PORTSC_OCC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 20)<br>
+#define=C2=A0 =C2=A0PORTSC_PRC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 21)<br>
+#define=C2=A0 =C2=A0PORTSC_PLC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 22)<br>
+#define=C2=A0 =C2=A0PORTSC_CEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 23)<br>
+#define=C2=A0 =C2=A0PORTSC_CAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 24)<br>
+#define=C2=A0 =C2=A0PORTSC_WCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 25)<br>
+#define=C2=A0 =C2=A0PORTSC_WDE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 26)<br>
+#define=C2=A0 =C2=A0PORTSC_WOE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 27)<br>
+#define=C2=A0 =C2=A0PORTSC_DR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 30)<br>
+#define=C2=A0 =C2=A0PORTSC_WPR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 31)<br>
+#define XHCI_PORT_PORTPMSC=C2=A0 =C2=A0 =C2=A0 =C2=A00x04<br>
+#define XHCI_PORT_PORTLI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
+#define XHCI_PORT_PORTHLPMC=C2=A0 =C2=A0 =C2=A0 0x0C<br>
+<br>
+#define XHCI_OPER_USBCMD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00<br>
+#define=C2=A0 =C2=A0USBCMD_RS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 0)<br>
+#define=C2=A0 =C2=A0USBCMD_HCRST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(=
1 &lt;&lt; 1)<br>
+#define=C2=A0 =C2=A0USBCMD_INTE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
1 &lt;&lt; 2)<br>
+#define=C2=A0 =C2=A0USBCMD_HSEE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
1 &lt;&lt; 3)<br>
+#define=C2=A0 =C2=A0USBCMD_LHCRST=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt=
;&lt; 7)<br>
+#define=C2=A0 =C2=A0USBCMD_CSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 8)<br>
+#define=C2=A0 =C2=A0USBCMD_CRS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 9)<br>
+#define=C2=A0 =C2=A0USBCMD_EWE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 10)<br>
+#define=C2=A0 =C2=A0USBCMD_EU3S=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
1 &lt;&lt; 11)<br>
+#define XHCI_OPER_USBSTS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x04<br>
+#define=C2=A0 =C2=A0USBSTS_HCH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 0)<br>
+#define=C2=A0 =C2=A0USBSTS_HSE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 2)<br>
+#define=C2=A0 =C2=A0USBSTS_EINT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (=
1 &lt;&lt; 3)<br>
+#define=C2=A0 =C2=A0USBSTS_PCD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 4)<br>
+#define=C2=A0 =C2=A0USBSTS_SSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 8)<br>
+#define=C2=A0 =C2=A0USBSTS_RSS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 9)<br>
+#define=C2=A0 =C2=A0USBSTS_SRE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 10)<br>
+#define=C2=A0 =C2=A0USBSTS_CNR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 11)<br>
+#define=C2=A0 =C2=A0USBSTS_HCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0(1 &lt;&lt; 12)<br>
+#define XHCI_OPER_PAGESIZE=C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
+#define XHCI_OPER_DNCTRL=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x14<br>
+#define XHCI_OPER_CRCR_LO=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x18<br>
+#define=C2=A0 =C2=A0CRCR_RCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 0)<br>
+#define=C2=A0 =C2=A0CRCR_CS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; 1)<br>
+#define=C2=A0 =C2=A0CRCR_CA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; 2)<br>
+#define=C2=A0 =C2=A0CRCR_CRR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 (1 &lt;&lt; 3)<br>
+#define XHCI_OPER_CRCR_HI=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1C<br>
+#define XHCI_OPER_DCBAAP_LO=C2=A0 =C2=A0 =C2=A0 0x30<br>
+#define XHCI_OPER_DCBAAP_HI=C2=A0 =C2=A0 =C2=A0 0x34<br>
+#define XHCI_OPER_CONFIG=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x38<br>
+<br>
+#define XHCI_OPER_MFINDEX=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x00<br>
+#define XHCI_OPER_IR0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20<br>
+#define XHCI_OPER_IR_SZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0x20<br>
+<br>
+#define XHCI_INTR_IMAN=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x00<br>
+#define=C2=A0 =C2=A0IMAN_IP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; 0)<br>
+#define=C2=A0 =C2=A0IMAN_IE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 (1 &lt;&lt; 1)<br>
+#define XHCI_INTR_IMOD=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x04<br>
+#define XHCI_INTR_ERSTSZ=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00x08<br>
+#define XHCI_INTR_ERSTBA_LO=C2=A0 =C2=A0 =C2=A0 0x10<br>
+#define XHCI_INTR_ERSTBA_HI=C2=A0 =C2=A0 =C2=A0 0x14<br>
+#define XHCI_INTR_ERDP_LO=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x18<br>
+#define=C2=A0 =C2=A0ERDP_EHB=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0(1 &lt;&lt; 3)<br>
+#define XHCI_INTR_ERDP_HI=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x1C<br>
+<br>
+#define TRB_SIZE 16<br>
+typedef struct XHCITRB {<br>
+=C2=A0 =C2=A0 uint64_t parameter;<br>
+=C2=A0 =C2=A0 uint32_t status;<br>
+=C2=A0 =C2=A0 uint32_t control;<br>
+=C2=A0 =C2=A0 dma_addr_t addr;<br>
+=C2=A0 =C2=A0 bool ccs;<br>
+} XHCITRB;<br>
+<br>
+enum {<br>
+=C2=A0 =C2=A0 PLS_U0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 0,<br>
+=C2=A0 =C2=A0 PLS_U1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 1,<br>
+=C2=A0 =C2=A0 PLS_U2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 2,<br>
+=C2=A0 =C2=A0 PLS_U3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 3,<br>
+=C2=A0 =C2=A0 PLS_DISABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 4,<br>
+=C2=A0 =C2=A0 PLS_RX_DETECT=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 5,<br>
+=C2=A0 =C2=A0 PLS_INACTIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 6,<br>
+=C2=A0 =C2=A0 PLS_POLLING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 7,<br=
>
+=C2=A0 =C2=A0 PLS_RECOVERY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 8,<br>
+=C2=A0 =C2=A0 PLS_HOT_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 9,<br>
+=C2=A0 =C2=A0 PLS_COMPILANCE_MODE =3D 10,<br>
+=C2=A0 =C2=A0 PLS_TEST_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 11,<br>
+=C2=A0 =C2=A0 PLS_RESUME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
+};<br>
+<br>
+#define CR_LINK TR_LINK<br>
+<br>
+#define TRB_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt=
;&lt; 0)<br>
+#define TRB_TYPE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10<br>
+#define TRB_TYPE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x3f<br>
+#define TRB_TYPE(t)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((t).control &gt;&gt=
; TRB_TYPE_SHIFT) &amp; TRB_TYPE_MASK)<br>
+<br>
+#define TRB_EV_ED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 2)<b=
r>
+<br>
+#define TRB_TR_ENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 1)<br>
+#define TRB_TR_ISP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 2)<br>
+#define TRB_TR_NS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 3)<b=
r>
+#define TRB_TR_CH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 4)<b=
r>
+#define TRB_TR_IOC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 5)<br>
+#define TRB_TR_IDT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 6)<br>
+#define TRB_TR_TBC_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 7<br>
+#define TRB_TR_TBC_MASK=C2=A0 =C2=A0 =C2=A00x3<br>
+#define TRB_TR_BEI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 9)<br>
+#define TRB_TR_TLBPC_SHIFT=C2=A0 =C2=A0 =C2=A0 16<br>
+#define TRB_TR_TLBPC_MASK=C2=A0 =C2=A00xf<br>
+#define TRB_TR_FRAMEID_SHIFT=C2=A0 =C2=A0 20<br>
+#define TRB_TR_FRAMEID_MASK 0x7ff<br>
+#define TRB_TR_SIA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 31)<br>
+<br>
+#define TRB_TR_DIR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 16)<br>
+<br>
+#define TRB_CR_SLOTID_SHIFT=C2=A0 =C2=A0 =C2=A024<br>
+#define TRB_CR_SLOTID_MASK=C2=A0 0xff<br>
+#define TRB_CR_EPID_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
+#define TRB_CR_EPID_MASK=C2=A0 =C2=A0 0x1f<br>
+<br>
+#define TRB_CR_BSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 9)<br>
+#define TRB_CR_DC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 9)<b=
r>
+<br>
+#define TRB_LK_TC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1 &lt;&lt; 1)<b=
r>
+<br>
+#define TRB_INTR_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22<br>
+#define TRB_INTR_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x3ff<br>
+#define TRB_INTR(t)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((t).status &gt;&gt;=
 TRB_INTR_SHIFT) &amp; TRB_INTR_MASK)<br>
+<br>
+#define EP_TYPE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x7<br>
+#define EP_TYPE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
+<br>
+#define EP_STATE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x7<br>
+#define EP_DISABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0 &lt;&lt; 0)<br>
+#define EP_RUNNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1 &lt;&lt; 0)<br>
+#define EP_HALTED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(2 &lt;&lt; 0)<b=
r>
+#define EP_STOPPED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (3 &lt;&lt; 0)<br>
+#define EP_ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (4 &lt;&lt; 0)<b=
r>
+<br>
+#define SLOT_STATE_MASK=C2=A0 =C2=A0 =C2=A00x1f<br>
+#define SLOT_STATE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 27<br>
+#define SLOT_STATE(s)=C2=A0 =C2=A0 =C2=A0 =C2=A0(((s) &gt;&gt; SLOT_STATE_=
SHIFT) &amp; SLOT_STATE_MASK)<br>
+#define SLOT_ENABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
+#define SLOT_DEFAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
+#define SLOT_ADDRESSED=C2=A0 =C2=A0 =C2=A0 2<br>
+#define SLOT_CONFIGURED=C2=A0 =C2=A0 =C2=A03<br>
+<br>
+#define SLOT_CONTEXT_ENTRIES_MASK 0x1f<br>
+#define SLOT_CONTEXT_ENTRIES_SHIFT 27<br>
+<br>
+typedef enum EPType {<br>
+=C2=A0 =C2=A0 ET_INVALID =3D 0,<br>
+=C2=A0 =C2=A0 ET_ISO_OUT,<br>
+=C2=A0 =C2=A0 ET_BULK_OUT,<br>
+=C2=A0 =C2=A0 ET_INTR_OUT,<br>
+=C2=A0 =C2=A0 ET_CONTROL,<br>
+=C2=A0 =C2=A0 ET_ISO_IN,<br>
+=C2=A0 =C2=A0 ET_BULK_IN,<br>
+=C2=A0 =C2=A0 ET_INTR_IN,<br>
+} EPType;<br>
+<br>
=C2=A0typedef struct XHCIRing {<br>
=C2=A0 =C2=A0 =C2=A0dma_addr_t dequeue;<br>
=C2=A0 =C2=A0 =C2=A0bool ccs;<br>
diff --git a/hw/usb/hcd-xhci.c b/hw/usb/hcd-xhci.c<br>
index d85adaca0dc..df0421ec326 100644<br>
--- a/hw/usb/hcd-xhci.c<br>
+++ b/hw/usb/hcd-xhci.c<br>
@@ -65,154 +65,6 @@<br>
=C2=A0# error Increase XHCI_LEN_REGS<br>
=C2=A0#endif<br>
<br>
-/* bit definitions */<br>
-#define USBCMD_RS=C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;0)<br>
-#define USBCMD_HCRST=C2=A0 =C2=A0 (1&lt;&lt;1)<br>
-#define USBCMD_INTE=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;2)<br>
-#define USBCMD_HSEE=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;3)<br>
-#define USBCMD_LHCRST=C2=A0 =C2=A0(1&lt;&lt;7)<br>
-#define USBCMD_CSS=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;8)<br>
-#define USBCMD_CRS=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;9)<br>
-#define USBCMD_EWE=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;10)<br>
-#define USBCMD_EU3S=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;11)<br>
-<br>
-#define USBSTS_HCH=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;0)<br>
-#define USBSTS_HSE=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;2)<br>
-#define USBSTS_EINT=C2=A0 =C2=A0 =C2=A0(1&lt;&lt;3)<br>
-#define USBSTS_PCD=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;4)<br>
-#define USBSTS_SSS=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;8)<br>
-#define USBSTS_RSS=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;9)<br>
-#define USBSTS_SRE=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;10)<br>
-#define USBSTS_CNR=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;11)<br>
-#define USBSTS_HCE=C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;12)<br>
-<br>
-<br>
-#define PORTSC_CCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;0)<br>
-#define PORTSC_PED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;1)<br>
-#define PORTSC_OCA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;3)<br>
-#define PORTSC_PR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;4)<br>
-#define PORTSC_PLS_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 5<br>
-#define PORTSC_PLS_MASK=C2=A0 =C2=A0 =C2=A00xf<br>
-#define PORTSC_PP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;9)<br>
-#define PORTSC_SPEED_SHIFT=C2=A0 =C2=A0 =C2=A0 10<br>
-#define PORTSC_SPEED_MASK=C2=A0 =C2=A00xf<br>
-#define PORTSC_SPEED_FULL=C2=A0 =C2=A0(1&lt;&lt;10)<br>
-#define PORTSC_SPEED_LOW=C2=A0 =C2=A0 (2&lt;&lt;10)<br>
-#define PORTSC_SPEED_HIGH=C2=A0 =C2=A0(3&lt;&lt;10)<br>
-#define PORTSC_SPEED_SUPER=C2=A0 (4&lt;&lt;10)<br>
-#define PORTSC_PIC_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 14<br>
-#define PORTSC_PIC_MASK=C2=A0 =C2=A0 =C2=A00x3<br>
-#define PORTSC_LWS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;16)<br>
-#define PORTSC_CSC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;17)<br>
-#define PORTSC_PEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;18)<br>
-#define PORTSC_WRC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;19)<br>
-#define PORTSC_OCC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;20)<br>
-#define PORTSC_PRC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;21)<br>
-#define PORTSC_PLC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;22)<br>
-#define PORTSC_CEC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;23)<br>
-#define PORTSC_CAS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;24)<br>
-#define PORTSC_WCE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;25)<br>
-#define PORTSC_WDE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;26)<br>
-#define PORTSC_WOE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;27)<br>
-#define PORTSC_DR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;30)<br=
>
-#define PORTSC_WPR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;31)<br>
-<br>
-#define CRCR_RCS=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;0)<br>
-#define CRCR_CS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;1)<br>
-#define CRCR_CA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;2)<br>
-#define CRCR_CRR=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;3)<br>
-<br>
-#define IMAN_IP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;0)<br>
-#define IMAN_IE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;1)<br>
-<br>
-#define ERDP_EHB=C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;3)<br>
-<br>
-#define TRB_SIZE 16<br>
-typedef struct XHCITRB {<br>
-=C2=A0 =C2=A0 uint64_t parameter;<br>
-=C2=A0 =C2=A0 uint32_t status;<br>
-=C2=A0 =C2=A0 uint32_t control;<br>
-=C2=A0 =C2=A0 dma_addr_t addr;<br>
-=C2=A0 =C2=A0 bool ccs;<br>
-} XHCITRB;<br>
-<br>
-enum {<br>
-=C2=A0 =C2=A0 PLS_U0=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 0,<br>
-=C2=A0 =C2=A0 PLS_U1=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 1,<br>
-=C2=A0 =C2=A0 PLS_U2=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 2,<br>
-=C2=A0 =C2=A0 PLS_U3=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=
=C2=A0 3,<br>
-=C2=A0 =C2=A0 PLS_DISABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 4,<br>
-=C2=A0 =C2=A0 PLS_RX_DETECT=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 5,<br>
-=C2=A0 =C2=A0 PLS_INACTIVE=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 6,<br>
-=C2=A0 =C2=A0 PLS_POLLING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 7,<br=
>
-=C2=A0 =C2=A0 PLS_RECOVERY=C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D=C2=A0 8,<br>
-=C2=A0 =C2=A0 PLS_HOT_RESET=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D=C2=A0 9,<br>
-=C2=A0 =C2=A0 PLS_COMPILANCE_MODE =3D 10,<br>
-=C2=A0 =C2=A0 PLS_TEST_MODE=C2=A0 =C2=A0 =C2=A0 =C2=A0=3D 11,<br>
-=C2=A0 =C2=A0 PLS_RESUME=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =3D 15,<br>
-};<br>
-<br>
-#define CR_LINK TR_LINK<br>
-<br>
-#define TRB_C=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;=
&lt;0)<br>
-#define TRB_TYPE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 10<br>
-#define TRB_TYPE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x3f<br>
-#define TRB_TYPE(t)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((t).control &gt;&gt=
; TRB_TYPE_SHIFT) &amp; TRB_TYPE_MASK)<br>
-<br>
-#define TRB_EV_ED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;2)<br>
-<br>
-#define TRB_TR_ENT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;1)<br>
-#define TRB_TR_ISP=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;2)<br>
-#define TRB_TR_NS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;3)<br>
-#define TRB_TR_CH=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;4)<br>
-#define TRB_TR_IOC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;5)<br>
-#define TRB_TR_IDT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;6)<br>
-#define TRB_TR_TBC_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 7<br>
-#define TRB_TR_TBC_MASK=C2=A0 =C2=A0 =C2=A00x3<br>
-#define TRB_TR_BEI=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;9)<br>
-#define TRB_TR_TLBPC_SHIFT=C2=A0 =C2=A0 =C2=A0 16<br>
-#define TRB_TR_TLBPC_MASK=C2=A0 =C2=A00xf<br>
-#define TRB_TR_FRAMEID_SHIFT=C2=A0 =C2=A0 20<br>
-#define TRB_TR_FRAMEID_MASK 0x7ff<br>
-#define TRB_TR_SIA=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;31)<br>
-<br>
-#define TRB_TR_DIR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;16)<br>
-<br>
-#define TRB_CR_SLOTID_SHIFT=C2=A0 =C2=A0 =C2=A024<br>
-#define TRB_CR_SLOTID_MASK=C2=A0 0xff<br>
-#define TRB_CR_EPID_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A016<br>
-#define TRB_CR_EPID_MASK=C2=A0 =C2=A0 0x1f<br>
-<br>
-#define TRB_CR_BSR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;9)<br>
-#define TRB_CR_DC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;9)<br>
-<br>
-#define TRB_LK_TC=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(1&lt;&lt;1)<br>
-<br>
-#define TRB_INTR_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 22<br>
-#define TRB_INTR_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x3ff<br>
-#define TRB_INTR(t)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(((t).status &gt;&gt;=
 TRB_INTR_SHIFT) &amp; TRB_INTR_MASK)<br>
-<br>
-#define EP_TYPE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A0 0x7<br>
-#define EP_TYPE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A03<br>
-<br>
-#define EP_STATE_MASK=C2=A0 =C2=A0 =C2=A0 =C2=A00x7<br>
-#define EP_DISABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(0&lt;&lt;0)<br>
-#define EP_RUNNING=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (1&lt;&lt;0)<br>
-#define EP_HALTED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0(2&lt;&lt;0)<br>
-#define EP_STOPPED=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (3&lt;&lt;0)<br>
-#define EP_ERROR=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (4&lt;&lt;0)<br>
-<br>
-#define SLOT_STATE_MASK=C2=A0 =C2=A0 =C2=A00x1f<br>
-#define SLOT_STATE_SHIFT=C2=A0 =C2=A0 =C2=A0 =C2=A0 27<br>
-#define SLOT_STATE(s)=C2=A0 =C2=A0 =C2=A0 =C2=A0(((s)&gt;&gt;SLOT_STATE_SH=
IFT)&amp;SLOT_STATE_MASK)<br>
-#define SLOT_ENABLED=C2=A0 =C2=A0 =C2=A0 =C2=A0 0<br>
-#define SLOT_DEFAULT=C2=A0 =C2=A0 =C2=A0 =C2=A0 1<br>
-#define SLOT_ADDRESSED=C2=A0 =C2=A0 =C2=A0 2<br>
-#define SLOT_CONFIGURED=C2=A0 =C2=A0 =C2=A03<br>
-<br>
-#define SLOT_CONTEXT_ENTRIES_MASK 0x1f<br>
-#define SLOT_CONTEXT_ENTRIES_SHIFT 27<br>
-<br>
=C2=A0#define get_field(data, field)=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 \<br>
=C2=A0 =C2=A0 =C2=A0(((data) &gt;&gt; field##_SHIFT) &amp; field##_MASK)<br=
>
<br>
@@ -223,17 +75,6 @@ enum {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*data =3D val_;=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0\<br>
=C2=A0 =C2=A0 =C2=A0} while (0)<br>
<br>
-typedef enum EPType {<br>
-=C2=A0 =C2=A0 ET_INVALID =3D 0,<br>
-=C2=A0 =C2=A0 ET_ISO_OUT,<br>
-=C2=A0 =C2=A0 ET_BULK_OUT,<br>
-=C2=A0 =C2=A0 ET_INTR_OUT,<br>
-=C2=A0 =C2=A0 ET_CONTROL,<br>
-=C2=A0 =C2=A0 ET_ISO_IN,<br>
-=C2=A0 =C2=A0 ET_BULK_IN,<br>
-=C2=A0 =C2=A0 ET_INTR_IN,<br>
-} EPType;<br>
-<br>
=C2=A0typedef struct XHCITransfer {<br>
=C2=A0 =C2=A0 =C2=A0XHCIEPContext *epctx;<br>
=C2=A0 =C2=A0 =C2=A0USBPacket packet;<br>
@@ -2736,56 +2577,55 @@ static uint64_t xhci_cap_read(void *ptr, hwaddr reg=
, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>
-=C2=A0 =C2=A0 case 0x00: /* HCIVERSION, CAPLENGTH */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_CAPLENGTH: /* Covers HCIVERSION and CAPLENGT=
H */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x01000000 | LEN_CAP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x04: /* HCSPARAMS 1 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_HCSPARAMS1:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D ((xhci-&gt;numports_2+xhci-&gt;nu=
mports_3)&lt;&lt;24)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| (xhci-&gt;numintrs&lt;&lt=
;8) | xhci-&gt;numslots;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x08: /* HCSPARAMS 2 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_HCSPARAMS2:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x0000000f;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x0c: /* HCSPARAMS 3 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_HCSPARAMS3:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x00000000;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x10: /* HCCPARAMS */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sizeof(dma_addr_t) =3D=3D 4) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x00080000 | (xhci-&gt;m=
ax_pstreams_mask &lt;&lt; 12);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D 0x00080001 | (xhci-&gt;m=
ax_pstreams_mask &lt;&lt; 12);<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_HCCPARAMS1:<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 ret =3D (XHCI_HCCAP_EXTCAP_START &gt;&gt; 2) |=
 (xhci-&gt;max_pstreams_mask &lt;&lt; 12);<br></blockquote><div><br></div><=
div>This doesn&#39;t look like it&#39;s equivalent to the original code. I =
think you want</div><div>((XHCI_HCCAP_EXTCAP_START &gt;&gt; 2) &lt;&lt; 16)=
 | (xhci-&gt;max_pstreams_mask &lt;&lt; 12);</div><div><br></div><div>That&=
#39;s=E2=80=A6 not particularly readable either though, so if we&#39;re goi=
ng to break up the magic numbers here, how about something like:</div><div>=
<br></div><div>ret =3D (XHCI_HCCAP_EXTCAP_START / 4) &lt;&lt; XHCI_HCCPARAM=
_EXTPTR_SHIFT;</div><div>ret |=3D xhci-&gt;max_pstreams_mask &lt;&lt;=C2=A0=
XHCI_HCCPARAM_MAXPSASIZE_SHIFT;</div><div>=C2=A0</div><blockquote class=3D"=
gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(20=
4,204,204);padding-left:1ex">
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (sizeof(dma_addr_t) =3D=3D 8) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ret |=3D 0x00000001; /* AC64 */ =
<br></blockquote><div><br></div><div>and then this can become</div><div>ret=
 |=3D XHCI_HCCPARAM_AC64;</div><div><br></div><div>or something like that.<=
br></div><div><br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x14: /* DBOFF */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_DBOFF:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D OFF_DOORBELL;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x18: /* RTSOFF */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_RTSOFF:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D OFF_RUNTIME;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
=C2=A0 =C2=A0 =C2=A0/* extended capabilities */<br>
-=C2=A0 =C2=A0 case 0x20: /* Supported Protocol:00 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x00: /* Supported Protocol:0=
0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x02000402; /* USB 2.0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x24: /* Supported Protocol:04 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x04: /* Supported Protocol:0=
4 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x20425355; /* &quot;USB &quot; *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x28: /* Supported Protocol:08 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x08: /* Supported Protocol:0=
8 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D (xhci-&gt;numports_2 &lt;&lt; 8) =
| (xhci-&gt;numports_3 + 1);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x2c: /* Supported Protocol:0c */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x0c: /* Supported Protocol:0=
c */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x00000000; /* reserved */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x30: /* Supported Protocol:00 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x10: /* Supported Protocol:0=
0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x03000002; /* USB 3.0 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x34: /* Supported Protocol:04 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x14: /* Supported Protocol:0=
4 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x20425355; /* &quot;USB &quot; *=
/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x38: /* Supported Protocol:08 */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x18: /* Supported Protocol:0=
8 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D (xhci-&gt;numports_3 &lt;&lt; 8) =
| 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x3c: /* Supported Protocol:0c */<br>
+=C2=A0 =C2=A0 case XHCI_HCCAP_EXTCAP_START + 0x1c: /* Supported Protocol:0=
c */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0x00000000; /* reserved */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
@@ -2803,14 +2643,13 @@ static uint64_t xhci_port_read(void *ptr, hwaddr re=
g, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>
-=C2=A0 =C2=A0 case 0x00: /* PORTSC */<br>
+=C2=A0 =C2=A0 case XHCI_PORT_PORTSC:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D port-&gt;portsc;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x04: /* PORTPMSC */<br>
-=C2=A0 =C2=A0 case 0x08: /* PORTLI */<br>
+=C2=A0 =C2=A0 case XHCI_PORT_PORTPMSC:<br>
+=C2=A0 =C2=A0 case XHCI_PORT_PORTLI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x0c: /* reserved */<br></blockquote><div><br></div><di=
v>I think it&#39;s worth keeping explicitly unhandled case labels documente=
d like this. (This one appears to be XHCI_PORT_PORTHLPMC nowadays, I assume=
 it was reserved in an earlier spec version.)<br></div><div><br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_usb_xhci_unimplemented(&quot;port r=
ead&quot;, reg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 0;<br>
@@ -2829,7 +2668,7 @@ static void xhci_port_write(void *ptr, hwaddr reg,<br=
>
=C2=A0 =C2=A0 =C2=A0trace_usb_xhci_port_write(port-&gt;portnr, reg, val);<b=
r>
<br>
=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>
-=C2=A0 =C2=A0 case 0x00: /* PORTSC */<br>
+=C2=A0 =C2=A0 case XHCI_PORT_PORTSC:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* write-1-to-start bits */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; PORTSC_WPR) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci_port_reset(port, true)=
;<br>
@@ -2880,8 +2719,6 @@ static void xhci_port_write(void *ptr, hwaddr reg,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci_port_notify(port, noti=
fy);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x04: /* PORTPMSC */<br>
-=C2=A0 =C2=A0 case 0x08: /* PORTLI */<br></blockquote><div><br></div><div>=
Hmm. Looks like PORTLI is actually a read-only register, so writing this ou=
ght to trigger a LOG_GUEST_ERROR. And I don&#39;t think it&#39;s a bad thin=
g to explicitly document PORTPMSC as unimplemented. (And I guess that ought=
 to be a LOG_UNIMP, not a trace, sigh.) The improved logging can be a separ=
ate commit - in fact I don&#39;t mind tagging  that fix onto my own pending=
 XHCI patch set, but I think for this commit we ought to keep the case labe=
ls (with the new symbolic constants).<br></div><div>=C2=A0</div><blockquote=
 class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px so=
lid rgb(204,204,204);padding-left:1ex">
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_usb_xhci_unimplemented(&quot;port w=
rite&quot;, reg);<br>
=C2=A0 =C2=A0 =C2=A0}<br>
@@ -2893,31 +2730,31 @@ static uint64_t xhci_oper_read(void *ptr, hwaddr re=
g, unsigned size)<br>
=C2=A0 =C2=A0 =C2=A0uint32_t ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>
-=C2=A0 =C2=A0 case 0x00: /* USBCMD */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_USBCMD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;usbcmd;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x04: /* USBSTS */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_USBSTS:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;usbsts;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x08: /* PAGESIZE */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_PAGESIZE:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D 1; /* 4KiB */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x14: /* DNCTRL */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_DNCTRL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;dnctrl;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x18: /* CRCR low */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_CRCR_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;crcr_low &amp; ~0xe;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x1c: /* CRCR high */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_CRCR_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;crcr_high;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x30: /* DCBAAP low */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_DCBAAP_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;dcbaap_low;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x34: /* DCBAAP high */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_DCBAAP_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;dcbaap_high;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x38: /* CONFIG */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_CONFIG:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci-&gt;config;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
@@ -2937,7 +2774,7 @@ static void xhci_oper_write(void *ptr, hwaddr reg,<br=
>
=C2=A0 =C2=A0 =C2=A0trace_usb_xhci_oper_write(reg, val);<br>
<br>
=C2=A0 =C2=A0 =C2=A0switch (reg) {<br>
-=C2=A0 =C2=A0 case 0x00: /* USBCMD */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_USBCMD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((val &amp; USBCMD_RS) &amp;&amp; !(xh=
ci-&gt;usbcmd &amp; USBCMD_RS)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci_run(xhci);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else if (!(val &amp; USBCMD_RS) &amp;&a=
mp; (xhci-&gt;usbcmd &amp; USBCMD_RS)) {<br>
@@ -2959,19 +2796,19 @@ static void xhci_oper_write(void *ptr, hwaddr reg,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci_intr_update(xhci, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
-=C2=A0 =C2=A0 case 0x04: /* USBSTS */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_USBSTS:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* these bits are write-1-to-clear */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;usbsts &amp;=3D ~(val &amp; (USB=
STS_HSE|USBSTS_EINT|USBSTS_PCD|USBSTS_SRE));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci_intr_update(xhci, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
<br>
-=C2=A0 =C2=A0 case 0x14: /* DNCTRL */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_DNCTRL:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;dnctrl =3D val &amp; 0xffff;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x18: /* CRCR low */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_CRCR_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;crcr_low =3D (val &amp; 0xffffff=
cf) | (xhci-&gt;crcr_low &amp; CRCR_CRR);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x1c: /* CRCR high */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_CRCR_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;crcr_high =3D val;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (xhci-&gt;crcr_low &amp; (CRCR_CA|CRCR=
_CS) &amp;&amp; (xhci-&gt;crcr_low &amp; CRCR_CRR)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XHCIEvent event =3D {ER_COM=
MAND_COMPLETE, CC_COMMAND_RING_STOPPED};<br>
@@ -2984,13 +2821,13 @@ static void xhci_oper_write(void *ptr, hwaddr reg,<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;crcr_low &amp;=3D ~(CRCR_CA | CR=
CR_CS);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x30: /* DCBAAP low */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_DCBAAP_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;dcbaap_low =3D val &amp; 0xfffff=
fc0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x34: /* DCBAAP high */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_DCBAAP_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;dcbaap_high =3D val;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x38: /* CONFIG */<br>
+=C2=A0 =C2=A0 case XHCI_OPER_CONFIG:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci-&gt;config =3D val &amp; 0xff;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
@@ -3004,9 +2841,9 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr r=
eg,<br>
=C2=A0 =C2=A0 =C2=A0XHCIState *xhci =3D ptr;<br>
=C2=A0 =C2=A0 =C2=A0uint32_t ret =3D 0;<br>
<br>
-=C2=A0 =C2=A0 if (reg &lt; 0x20) {<br>
+=C2=A0 =C2=A0 if (reg &lt; XHCI_OPER_IR0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0switch (reg) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x00: /* MFINDEX */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_OPER_MFINDEX:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D xhci_mfindex_get(xh=
ci) &amp; 0x3fff;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0default:<br>
@@ -3014,28 +2851,28 @@ static uint64_t xhci_runtime_read(void *ptr, hwaddr=
 reg,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0} else {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 int v =3D (reg - 0x20) / 0x20;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 int v =3D (reg - XHCI_OPER_IR0) / XHCI_OPER_IR=
_SZ;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0XHCIInterrupter *intr =3D &amp;xhci-&gt;i=
ntr[v];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (reg &amp; 0x1f) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x00: /* IMAN */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 switch (reg &amp; (XHCI_OPER_IR_SZ - 1)) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_INTR_IMAN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D intr-&gt;iman;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x04: /* IMOD */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_INTR_IMOD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D intr-&gt;imod;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x08: /* ERSTSZ */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_INTR_ERSTSZ:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D intr-&gt;erstsz;<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x10: /* ERSTBA low */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_INTR_ERSTBA_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D intr-&gt;erstba_low=
;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x14: /* ERSTBA high */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_INTR_ERSTBA_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D intr-&gt;erstba_hig=
h;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x18: /* ERDP low */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_INTR_ERDP_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D intr-&gt;erdp_low;<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 case 0x1c: /* ERDP high */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 case XHCI_INTR_ERDP_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D intr-&gt;erdp_high;=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3054,15 +2891,15 @@ static void xhci_runtime_write(void *ptr, hwaddr re=
g,<br>
<br>
=C2=A0 =C2=A0 =C2=A0trace_usb_xhci_runtime_write(reg, val);<br>
<br>
-=C2=A0 =C2=A0 if (reg &lt; 0x20) {<br>
+=C2=A0 =C2=A0 if (reg &lt; XHCI_OPER_IR0) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0trace_usb_xhci_unimplemented(&quot;runtim=
e write&quot;, reg);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-=C2=A0 =C2=A0 v =3D (reg - 0x20) / 0x20;<br>
+=C2=A0 =C2=A0 v =3D (reg - XHCI_OPER_IR0) / XHCI_OPER_IR_SZ;<br>
=C2=A0 =C2=A0 =C2=A0intr =3D &amp;xhci-&gt;intr[v];<br>
<br>
-=C2=A0 =C2=A0 switch (reg &amp; 0x1f) {<br>
-=C2=A0 =C2=A0 case 0x00: /* IMAN */<br>
+=C2=A0 =C2=A0 switch (reg &amp; (XHCI_OPER_IR_SZ - 1)) {<br>
+=C2=A0 =C2=A0 case XHCI_INTR_IMAN:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; IMAN_IP) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;iman &amp;=3D ~IMA=
N_IP;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3070,13 +2907,13 @@ static void xhci_runtime_write(void *ptr, hwaddr re=
g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;iman |=3D val &amp; IMAN_IE;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci_intr_update(xhci, v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x04: /* IMOD */<br>
+=C2=A0 =C2=A0 case XHCI_INTR_IMOD:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;imod =3D val;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x08: /* ERSTSZ */<br>
+=C2=A0 =C2=A0 case XHCI_INTR_ERSTSZ:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;erstsz =3D val &amp; 0xffff;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x10: /* ERSTBA low */<br>
+=C2=A0 =C2=A0 case XHCI_INTR_ERSTBA_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (xhci-&gt;nec_quirks) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* NEC driver bug: it doesn=
&#39;t align this to 64 bytes */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;erstba_low =3D val=
 &amp; 0xfffffff0;<br>
@@ -3084,11 +2921,11 @@ static void xhci_runtime_write(void *ptr, hwaddr re=
g,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;erstba_low =3D val=
 &amp; 0xffffffc0;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x14: /* ERSTBA high */<br>
+=C2=A0 =C2=A0 case XHCI_INTR_ERSTBA_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;erstba_high =3D val;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xhci_er_reset(xhci, v);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x18: /* ERDP low */<br>
+=C2=A0 =C2=A0 case XHCI_INTR_ERDP_LO:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (val &amp; ERDP_EHB) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;erdp_low &amp;=3D =
~ERDP_EHB;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
@@ -3103,7 +2940,7 @@ static void xhci_runtime_write(void *ptr, hwaddr reg,=
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
-=C2=A0 =C2=A0 case 0x1c: /* ERDP high */<br>
+=C2=A0 =C2=A0 case XHCI_INTR_ERDP_HI:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0intr-&gt;erdp_high =3D val;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
-- <br>
2.45.2<br>
<br>
<br>
</blockquote></div></div>

--000000000000e1968d06298cca00--

