Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CAD6C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 17:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb28G-0000vo-2e; Fri, 16 Feb 2024 12:36:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rb28D-0000vV-VG
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:36:13 -0500
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rb28B-0006me-U4
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 12:36:13 -0500
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-6e104a8e3f7so1914795b3a.1
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708104970; x=1708709770; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=g3ZyChHdMolDJPWFg4CrXcpgpx/K2qPIY8LkU4Df2zU=;
 b=Gz+MdDXe3vnbGdAgaxnY37g5nM6jR6G+HTrVebjuTYKBu0Go0bVCMlQfgxerqAbFHI
 MCCH5IXx97Y7+MB1832VFMCipTYOuB4yKe8C4NxigBXDqSdTV33abS2d6pM0vtIdH9aB
 bAH/R4dCm5rntK1/IfRujjBpH1f1hy1fb1xBEA89x712eDIQwWjIe+R1l4THvipxuLur
 rE9pxnuRdd37ks+zyR/OdxIORs/DEqQo9OGmes/uw0sDR79zpuRtF1H6I1DXkv2IPFkO
 Uuz7TL1lOrwBVWDqI6coYQdFDLhLw1Ikzufxy3z/TytqozFxpCG0dAEQiXojHFTnlLQv
 J6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708104970; x=1708709770;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3ZyChHdMolDJPWFg4CrXcpgpx/K2qPIY8LkU4Df2zU=;
 b=eiAorb+86x9cwn6qPCoQcCGFflnuDhlHUpMFT6LFedn94tJSRc952iEaPA05iPwwJp
 GuclPDrpEDRtujqCpYbXmfiLA+zgK+DKdrOWSrK/KdHdgs6VLMFJhc+YWNQJjZAH6pro
 yJ3/b72l4DEF/fDLZbYCETJCpQYdky2U0h47suM5UGaaBjlVpHJPNyHTKkIHD4WL9IzV
 U2ebYKgFEl67lmJNYansVnLusXE0LbdrkUxOicqYvQaYTKLNNE53ZJCZgYFjlp6FG6f/
 Giui1kPTzWw454ZcyXqo5ESKHVpvj/RapqHs77NRtklR189/hChYil/jnK4c/8eA0eSD
 t98w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAmOnIo1sDOrIoOwSEsVpKS4cEJ+a/LXqfeU+dPR6nhBSBbYAXvTAVcjt0E0OYOmNGLf7VdfW4+kCIUH9ymZmqDXnAfEY=
X-Gm-Message-State: AOJu0YyhuBwBmJQJmoKU1vrtOkNRA/q9cynAsgjhv4sVKtTVerGNRV4K
 eauchrEhdGvYpJJZlYwTIFDd63OzmdsPSzvVLT71TXMT3X3xHu6F
X-Google-Smtp-Source: AGHT+IGiXDo4sudOp617jcz2uNbjAfR+LQhVZAEQWqcBgO038ZqakrZIrwEk6rNgkVQ+tggQ4spZiw==
X-Received: by 2002:a05:6a20:c704:b0:19f:2df0:1410 with SMTP id
 hi4-20020a056a20c70400b0019f2df01410mr6225517pzb.53.1708104970052; 
 Fri, 16 Feb 2024 09:36:10 -0800 (PST)
Received: from debian ([2601:641:300:14de:f1a:387c:5c5c:3099])
 by smtp.gmail.com with ESMTPSA id
 p19-20020a056a0026d300b006e0e3ef5f23sm207277pfw.101.2024.02.16.09.36.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 09:36:09 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 16 Feb 2024 09:35:55 -0800
To: Shiju Jose <shiju.jose@huawei.com>
Cc: fan <nifan.cxl@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 tanxiaofei <tanxiaofei@huawei.com>,
 "Zengtao (B)" <prime.zeng@hisilicon.com>, Linuxarm <linuxarm@huawei.com>,
 "fan.ni@samsung.com" <fan.ni@samsung.com>
Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
 control feature
Message-ID: <Zc-c-79gRJcyDugg@debian>
References: <20231124135338.1191-1-shiju.jose@huawei.com>
 <20231124135338.1191-3-shiju.jose@huawei.com>
 <Zc5cNLH9FS24qXTe@debian>
 <f6c14302e3f74fdc9eef41857b534e63@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6c14302e3f74fdc9eef41857b534e63@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pf1-x435.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 16, 2024 at 10:16:12AM +0000, Shiju Jose wrote:
> Hi Fan,
> 
> >-----Original Message-----
> >From: fan <nifan.cxl@gmail.com>
> >Sent: 15 February 2024 18:47
> >To: Shiju Jose <shiju.jose@huawei.com>
> >Cc: qemu-devel@nongnu.org; linux-cxl@vger.kernel.org; Jonathan Cameron
> ><jonathan.cameron@huawei.com>; tanxiaofei <tanxiaofei@huawei.com>;
> >Zengtao (B) <prime.zeng@hisilicon.com>; Linuxarm <linuxarm@huawei.com>;
> >fan.ni@samsung.com
> >Subject: Re: [PATCH v2 2/3] hw/cxl/cxl-mailbox-utils: Add device patrol scrub
> >control feature
> >
> >On Fri, Nov 24, 2023 at 09:53:36PM +0800, shiju.jose@huawei.com wrote:
> >> From: Shiju Jose <shiju.jose@huawei.com>
> >>
> >> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub
> >> control feature. The device patrol scrub proactively locates and makes
> >> corrections to errors in regular cycle. The patrol scrub control
> >> allows the request to configure patrol scrub input configurations.
> >>
> >> The patrol scrub control allows the requester to specify the number of
> >> hours for which the patrol scrub cycles must be completed, provided
> >> that the requested number is not less than the minimum number of hours
> >> for the patrol scrub cycle that the device is capable of. In addition,
> >> the patrol scrub controls allow the host to disable and enable the
> >> feature in case disabling of the feature is needed for other purposes
> >> such as performance-aware operations which require the background
> >> operations to be turned off.
> >>
> >> Reviewed-by: Davidlohr Bueso <dave@stgolabs.net>
> >> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> >> ---
> >
> >LGTM except for some minor comments inlined.
> >
> >
> >>  hw/cxl/cxl-mailbox-utils.c | 97
> >> +++++++++++++++++++++++++++++++++++++-
> >>  1 file changed, 96 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> >> index 1bbc9a48a6..5a6f4e4029 100644
> >> --- a/hw/cxl/cxl-mailbox-utils.c
> >> +++ b/hw/cxl/cxl-mailbox-utils.c
> >> @@ -809,6 +809,7 @@ typedef struct CXLSupportedFeatureEntry {  }
> >> QEMU_PACKED CXLSupportedFeatureEntry;
> >>
> >>  enum CXL_SUPPORTED_FEATURES_LIST {
> >> +    CXL_FEATURE_PATROL_SCRUB = 0,
> >>      CXL_FEATURE_MAX
> >>  };
> >>
> >> @@ -849,6 +850,37 @@ enum CXL_SET_FEATURE_FLAG_DATA_TRANSFER {
> >>      CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MAX
> >>  };
> >>
> >> +/* CXL r3.1 section 8.2.9.9.11.1: Device Patrol Scrub Control Feature
> >> +*/ static const QemuUUID patrol_scrub_uuid = {
> >> +    .data = UUID(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33,
> >> +                 0x75, 0x77, 0x4e, 0x06, 0xdb, 0x8a) };
> >> +
> >> +#define CXL_MEMDEV_PS_GET_FEATURE_VERSION    0x01
> >> +#define CXL_MEMDEV_PS_SET_FEATURE_VERSION    0x01
> >> +#define CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT    BIT(0)
> >> +#define CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT
> >BIT(1)
> >> +#define CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT    12
> >> +#define CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT    1
> >> +#define CXL_MEMDEV_PS_ENABLE_DEFAULT    0
> >> +
> >> +/* CXL memdev patrol scrub control attributes */ struct
> >> +CXLMemPatrolScrubReadAttrbs {
> >> +        uint8_t scrub_cycle_cap;
> >> +        uint16_t scrub_cycle;
> >> +        uint8_t scrub_flags;
> >> +} QEMU_PACKED cxl_memdev_ps_feat_read_attrbs;
> >> +
> >> +typedef struct CXLMemPatrolScrubWriteAttrbs {
> >> +    uint8_t scrub_cycle_hr;
> >> +    uint8_t scrub_flags;
> >> +} QEMU_PACKED CXLMemPatrolScrubWriteAttrbs;
> >> +
> >> +typedef struct CXLMemPatrolScrubSetFeature {
> >> +        CXLSetFeatureInHeader hdr;
> >> +        CXLMemPatrolScrubWriteAttrbs feat_data; } QEMU_PACKED
> >> +QEMU_ALIGNED(16) CXLMemPatrolScrubSetFeature;
> >> +
> >>  /* CXL r3.0 section 8.2.9.6.1: Get Supported Features (Opcode 0500h)
> >> */  static CXLRetCode cmd_features_get_supported(const struct cxl_cmd
> >*cmd,
> >>                                               uint8_t *payload_in, @@
> >> -872,7 +904,7 @@ static CXLRetCode cmd_features_get_supported(const
> >struct cxl_cmd *cmd,
> >>      uint16_t feat_entries = 0;
> >>
> >>      if (get_feats_in->count < sizeof(CXLSupportedFeatureHeader) ||
> >> -        get_feats_in->start_index > CXL_FEATURE_MAX) {
> >> +        get_feats_in->start_index >= CXL_FEATURE_MAX) {
> >
> >Not totally sure about this, the spec says "...Greater than..." although I also think
> >it should be >=. Similar things for the offset usage below.
> 
> Spec r3.1 described in Table 8-95. Get Supported Features Input Payload  as , 
> "Starting Feature Index: Index of the first requested Supported Feature Entry.
> Feature index is a zero-based value."
> Thus I believe get_feats_in->start_index >= CXL_FEATURE_MAX  is correct  because
> the feature index is zero-based value.
That is also my understanding.
> 
> Regarding the offset usage mentioned, can you point which code?
> Is it get_feature->offset? 
> 
Yea. Maybe not an issue as long as we keep all consistent.o

Fan
> >
> >Fan
> >
> >>          return CXL_MBOX_INVALID_INPUT;
> >>      }
> >>      req_entries = (get_feats_in->count - @@ -884,6 +916,31 @@ static
> >> CXLRetCode cmd_features_get_supported(const struct cxl_cmd *cmd,
> >>      entry = 0;
> >>      while (entry < req_entries) {
> >>          switch (index) {
> >> +        case  CXL_FEATURE_PATROL_SCRUB:
> >> +            /* Fill supported feature entry for device patrol scrub control */
> >> +            get_feats_out->feat_entries[entry] =
> >> +                           (struct CXLSupportedFeatureEntry) {
> >> +                .uuid = patrol_scrub_uuid,
> >> +                .feat_index = index,
> >> +                .get_feat_size = sizeof(cxl_memdev_ps_feat_read_attrbs),
> >> +                .set_feat_size = sizeof(CXLMemPatrolScrubWriteAttrbs),
> >> +                /* Bit[0] : 1, feature attributes changeable */
> >> +                .attrb_flags = 0x1,
> >> +                .get_feat_version = CXL_MEMDEV_PS_GET_FEATURE_VERSION,
> >> +                .set_feat_version = CXL_MEMDEV_PS_SET_FEATURE_VERSION,
> >> +                .set_feat_effects = 0,
> >> +            };
> >> +            feat_entries++;
> >> +            /* Set default value for device patrol scrub read attributes */
> >> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle_cap =
> >> +
> >CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_DEFAULT |
> >> +
> >CXL_MEMDEV_PS_SCRUB_REALTIME_REPORT_CAP_DEFAULT;
> >> +            cxl_memdev_ps_feat_read_attrbs.scrub_cycle =
> >> +                                CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_DEFAULT |
> >> +                                (CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_DEFAULT << 8);
> >> +            cxl_memdev_ps_feat_read_attrbs.scrub_flags =
> >> +                                CXL_MEMDEV_PS_ENABLE_DEFAULT;
> >> +            break;
> >>          default:
> >>              break;
> >>          }
> >> @@ -924,6 +981,21 @@ static CXLRetCode cmd_features_get_feature(const
> >struct cxl_cmd *cmd,
> >>          return CXL_MBOX_INVALID_INPUT;
> >>      }
> >>
> >> +    if (qemu_uuid_is_equal(&get_feature->uuid, &patrol_scrub_uuid)) {
> >> +        if (get_feature->offset >= sizeof(cxl_memdev_ps_feat_read_attrbs)) {
> >> +            return CXL_MBOX_INVALID_INPUT;
> >> +        }
> >> +        bytes_to_copy = sizeof(cxl_memdev_ps_feat_read_attrbs) -
> >> +                                             get_feature->offset;
> >> +        bytes_to_copy = (bytes_to_copy > get_feature->count) ?
> >> +                               get_feature->count : bytes_to_copy;
> >> +        memcpy(payload_out,
> >> +               &cxl_memdev_ps_feat_read_attrbs + get_feature->offset,
> >> +               bytes_to_copy);
> >> +    } else {
> >> +        return CXL_MBOX_UNSUPPORTED;
> >> +    }
> >> +
> >>      *len_out = bytes_to_copy;
> >>
> >>      return CXL_MBOX_SUCCESS;
> >> @@ -937,6 +1009,29 @@ static CXLRetCode cmd_features_set_feature(const
> >struct cxl_cmd *cmd,
> >>                                             size_t *len_out,
> >>                                             CXLCCI *cci)  {
> >> +    CXLMemPatrolScrubWriteAttrbs *ps_write_attrbs;
> >> +    CXLMemPatrolScrubSetFeature *ps_set_feature;
> >> +    CXLSetFeatureInHeader *hdr = (void *)payload_in;
> >> +
> >> +    if (qemu_uuid_is_equal(&hdr->uuid, &patrol_scrub_uuid)) {
> >> +        if (hdr->version != CXL_MEMDEV_PS_SET_FEATURE_VERSION ||
> >> +            (hdr->flags & CXL_SET_FEATURE_FLAG_DATA_TRANSFER_MASK) !=
> >> +                               CXL_SET_FEATURE_FLAG_FULL_DATA_TRANSFER) {
> >> +            return CXL_MBOX_UNSUPPORTED;
> >> +        }
> >> +
> >> +        ps_set_feature = (void *)payload_in;
> >> +        ps_write_attrbs = &ps_set_feature->feat_data;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle &= ~0xFF;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_cycle |=
> >> +                          ps_write_attrbs->scrub_cycle_hr & 0xFF;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags &= ~0x1;
> >> +        cxl_memdev_ps_feat_read_attrbs.scrub_flags |=
> >> +                          ps_write_attrbs->scrub_flags & 0x1;
> >> +    } else {
> >> +        return CXL_MBOX_UNSUPPORTED;
> >> +    }
> >> +
> >>      return CXL_MBOX_SUCCESS;
> >>  }
> >>
> >> --
> >> 2.34.1
> >>
> 
> Thanks,
> Shiju

