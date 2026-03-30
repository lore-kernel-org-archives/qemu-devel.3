Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B99310D14A3
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 11:30:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Aoe-0007SC-QW; Mon, 30 Mar 2026 07:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7AoU-0007RC-7w
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:29:46 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jaemyung.lee@samsung.com>)
 id 1w7AoR-0000ON-35
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 07:29:45 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20260330112940epoutp02746daf34140e9490c8e566d5c4f1beb4~hmwaeo8eS0573405734epoutp02H
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 11:29:40 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20260330112940epoutp02746daf34140e9490c8e566d5c4f1beb4~hmwaeo8eS0573405734epoutp02H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1774870180;
 bh=XRFk/3yBw6jFkXQRHHyKf77qOpw9CtbJITAXFfmULBI=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=Npnpibu5CHbTzrEkFR5LPzWzkQYnp5vpchyYZsWl6TQ/ugFXba3xRZSSgIIw6bZzA
 YqVTarSjAQjOBy51qe8V+KF5JKem0PkbRrFqffOqHzskLCGl3IDWHYR4z95VflRxRn
 9vq4nm8fUbXVJeJKMhRXRSjw8PnIVUv/mgL/i3zI=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20260330112940epcas2p4b3174f778a75a0952d18e967b8ed28a6~hmwaFmUWw1994519945epcas2p4P;
 Mon, 30 Mar 2026 11:29:40 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.200]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4fkptr0C3Wz6B9mD; Mon, 30 Mar
 2026 11:29:40 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 1/5] hw/ufs: Apply UFS 4.1 Specification
From: Jaemyung Lee <jaemyung.lee@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "farosas@suse.de"
 <farosas@suse.de>, "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260330112939epcms2p625b44cb396fb446f14598656249bd1b7@epcms2p6>
Date: Mon, 30 Mar 2026 20:29:39 +0900
X-CMS-MailID: 20260330112939epcms2p625b44cb396fb446f14598656249bd1b7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502
References: <CGME20260330112748epcms2p1717e93009f7fb87a8156ee07a9400502@epcms2p6>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=jaemyung.lee@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -6
X-Spam_score: -0.7
X-Spam_bar: /
X-Spam_report: (-0.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1, RCVD_IN_VALIDITY_RPBL_BLOCKED=1,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Reply-To: jaemyung.lee@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Apply current UFS 4.1 Specification to QEMU-UFS.

QEMU-UFS device emulates operation via UFS 4.0 Specification,
but current latest Spec. version is UFS 4.1. So extent internal
DESCRIPTOR/FLAG/ATTRIBUTE declaration to follow UFS 4.1 Spec.

It does not implement any actual functionallity, but only adds
minimum supportability for further implementation.

Signed-off-by: Jaemyung Lee <jameyung.lee=40samsung.com>
---
=C2=A0hw/ufs/ufs.c=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=2069=20++++++++++++++++=
+++++++++++++++++++++++++++--=0D=0A=C2=A0include/block/ufs.h=2059=20+++++++=
+++++++++++++++++++++++++++++--=0D=0A=C2=A02=20files=20changed,=20122=20ins=
ertions(+),=206=20deletions(-)=0D=0A=0D=0Adiff=20--git=20a/hw/ufs/ufs.c=20b=
/hw/ufs/ufs.c=0D=0Aindex=20cb74cb56bc..b2b70c8b38=20100644=0D=0A---=20a/hw/=
ufs/ufs.c=0D=0A+++=20b/hw/ufs/ufs.c=0D=0A=40=40=20-9,7=20+9,7=20=40=40=0D=
=0A=C2=A0=20*/=0D=0A=0D=0A=C2=A0/**=0D=0A-=20*=20Reference=20Specs:=20https=
://www.jedec.org/,=204.0=0D=0A+=20*=20Reference=20Specs:=20https://www.jede=
c.org/,=204.1=0D=0A=C2=A0=20*=0D=0A=C2=A0=20*=20Usage=0D=0A=C2=A0=20*=20---=
--=0D=0A=40=40=20-29,8=20+29,8=20=40=40=0D=0A=C2=A0=23include=20=22trace.h=
=22=0D=0A=C2=A0=23include=20=22ufs.h=22=0D=0A=0D=0A-/*=20The=20QEMU-UFS=20d=
evice=20follows=20spec=20version=204.0=20*/=0D=0A-=23define=20UFS_SPEC_VER=
=200x0400=0D=0A+/*=20The=20QEMU-UFS=20device=20follows=20spec=20version=204=
.1=20*/=0D=0A+=23define=20UFS_SPEC_VER=200x0410=0D=0A=C2=A0=23define=20UFS_=
MAX_NUTRS=2032=0D=0A=C2=A0=23define=20UFS_MAX_NUTMRS=208=0D=0A=C2=A0=23defi=
ne=20UFS_MCQ_QCFGPTR=202=0D=0A=40=40=20-1000,6=20+1000,7=20=40=40=20static=
=20const=20int=20flag_permission=5BUFS_QUERY_FLAG_IDN_COUNT=5D=20=3D=20=7B=
=0D=0A=C2=A0=20=C2=A0=20=C2=A0=5BUFS_QUERY_FLAG_IDN_WB_EN=5D=20=3D=20UFS_QU=
ERY_FLAG_READ,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=5BUFS_QUERY_FLAG_IDN_WB_BUFF_F=
LUSH_EN=5D=20=3D=20UFS_QUERY_FLAG_READ,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=5BUFS=
_QUERY_FLAG_IDN_WB_BUFF_FLUSH_DURING_HIBERN8=5D=20=3D=20UFS_QUERY_FLAG_READ=
,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_FLAG_IDN_UNPIN_EN=5D=20=3D=20UFS_QUE=
RY_FLAG_READ,=0D=0A=C2=A0=7D;=0D=0A=0D=0A=C2=A0static=20inline=20QueryRespC=
ode=20ufs_flag_check_idn_valid(uint8_t=20idn,=20int=20op)=0D=0A=40=40=20-10=
57,10=20+1058,31=20=40=40=20static=20const=20int=20attr_permission=5BUFS_QU=
ERY_ATTR_IDN_COUNT=5D=20=3D=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0=5BUFS_QUERY=
_ATTR_IDN_AVAIL_WB_BUFF_SIZE=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0=5BUFS_QUERY_ATTR_IDN_WB_BUFF_LIFE_TIME_EST=5D=20=3D=20UFS_Q=
UERY_ATTR_READ,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=5BUFS_QUERY_ATTR_IDN_CURR_WB_=
BUFF_SIZE=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QU=
ERY_ATTR_IDN_EXT_IID_EN=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=
=A0=20=5BUFS_QUERY_ATTR_IDN_HOST_HINT_CACHE_SIZE=5D=20=3D=20UFS_QUERY_ATTR_=
READ,=0D=0A=C2=A0=20=C2=A0=20=C2=A0/*=20refresh=20operation=20is=20not=20su=
pported=20*/=0D=0A=C2=A0=20=C2=A0=20=C2=A0=5BUFS_QUERY_ATTR_IDN_REFRESH_STA=
TUS=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A=C2=A0=20=C2=A0=20=C2=A0=5BUFS_QUE=
RY_ATTR_IDN_REFRESH_FREQ=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A=C2=A0=20=C2=
=A0=20=C2=A0=5BUFS_QUERY_ATTR_IDN_REFRESH_UNIT=5D=20=3D=20UFS_QUERY_ATTR_RE=
AD,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_TIMESTAMP=5D=20=3D=20UFS_=
QUERY_ATTR_WRITE,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_DEVICE_LEVE=
L_EXCEPTION_ID=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20/*=
=20host=20initiated=20defragmentation=20is=20not=20supported=20*/=0D=0A+=C2=
=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_DEFRAG_OP=5D=20=3D=20UFS_QUERY_ATTR_RE=
AD,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE=5D=20=3D=
=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_HID_S=
IZE=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_AT=
TR_IDN_HID_PROG_RATIO=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=
=20=5BUFS_QUERY_ATTR_IDN_HID_STATE=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=
=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT=5D=20=3D=20UFS_=
QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_WB_BUFF_RESI=
ZE_EN=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_=
ATTR_IDN_WB_BUFF_RESIZE_STATUS=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=
=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE=5D=20=3D=20UFS=
_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_MAX_FIFO_WB=
_PARTIAL_FLUSH_MODE=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=
=20=5BUFS_QUERY_ATTR_IDN_CURR_FIFO_WB_PARTIAL_FLUSH_MODE=5D=20=3D=20UFS_QUE=
RY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_=
CURR_ALLOC_UNITS=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=
=5BUFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_AVAIL_PERCENT=5D=20=3D=20UFS_QUERY_ATT=
R_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_PINNED_WB_CUMM_WRITTE=
N_SIZE=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=C2=A0=20=C2=A0=20=5BUFS_QUERY=
_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A+=
=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS=
=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A=C2=A0=7D;=0D=0A=0D=0A=C2=A0static=20=
inline=20QueryRespCode=20ufs_attr_check_idn_valid(uint8_t=20idn,=20int=20op=
)=0D=0A=40=40=20-1194,12=20+1216,50=20=40=40=20static=20uint32_t=20ufs_read=
_attr_value(UfsHc=20*u,=20uint8_t=20idn)=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0return=20u->attributes.wb_buffer_life_time_est;=0D=0A=C2=A0=
=20=C2=A0=20=C2=A0case=20UFS_QUERY_ATTR_IDN_CURR_WB_BUFF_SIZE:=0D=0A=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0return=20be32_to_cpu(u->attributes.curr=
ent_wb_buffer_size);=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_EXT_=
IID_EN:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20u->attributes.ex=
t_iid_en;=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_HOST_HINT_CACHE=
_SIZE:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20be16_to_cpu(u->at=
tributes.host_hint_cache_size);=0D=0A=C2=A0=20=C2=A0=20=C2=A0case=20UFS_QUE=
RY_ATTR_IDN_REFRESH_STATUS:=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
return=20u->attributes.refresh_status;=0D=0A=C2=A0=20=C2=A0=20=C2=A0case=20=
UFS_QUERY_ATTR_IDN_REFRESH_FREQ:=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0return=20u->attributes.refresh_freq;=0D=0A=C2=A0=20=C2=A0=20=C2=A0cas=
e=20UFS_QUERY_ATTR_IDN_REFRESH_UNIT:=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0return=20u->attributes.refresh_unit;=0D=0A+=C2=A0=20=C2=A0=20case=
=20UFS_QUERY_ATTR_IDN_DEVICE_LEVEL_EXCEPTION_ID:=0D=0A+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20return=20be64_to_cpu(u->attributes.device_level_exception=
_id);=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_DEFRAG_OP:=0D=0A+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20u->attributes.defrag_op;=0D=0A=
+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZE:=0D=0A+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20return=20be32_to_cpu(u->attributes.hid_avail_=
size);=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_HID_SIZE:=0D=0A+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20be32_to_cpu(u->attributes.hid_=
size);=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_HID_PROG_RATIO:=0D=
=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20u->attributes.hid_prog_rat=
io;=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_HID_STATE:=0D=0A+=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20u->attributes.hid_state;=0D=0A+=
=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT:=0D=0A+=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20u->attributes.wb_buffer_resize_hi=
nt;=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN:=0D=
=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20u->attributes.wb_buffer_re=
size_en;=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_S=
TATUS:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20u->attributes.wb_=
buffer_resize_status;=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_WB_=
BUFF_PARTIAL_FLUSH_MODE:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=
=20u->attributes.wb_buffer_partial_flush_mode;=0D=0A+=C2=A0=20=C2=A0=20case=
=20UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTIAL_FLUSH_MODE:=0D=0A+=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20return=20be32_to_cpu(u->attributes.max_fifo_wb_partial=
_flush_mode);=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_CURR_FIFO_W=
B_PARTIAL_FLUSH_MODE:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20be=
32_to_cpu(u->attributes.curr_fifo_wb_partial_flush_mode);=0D=0A+=C2=A0=20=
=C2=A0=20case=20UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_CURR_ALLOC_UNITS:=0D=0A+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20be32_to_cpu(u->attributes.pinn=
ed_wb_buffer_curr_alloc_units);=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_AT=
TR_IDN_PINNED_WB_BUFF_AVAIL_PERCENT:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20return=20u->attributes.pinned_wb_buffer_avail_percent;=0D=0A+=C2=A0=
=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN_PINNED_WB_CUMM_WRITTEN_SIZE:=0D=0A+=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20be32_to_cpu(u->attributes.pinn=
ed_wb_cumm_written_size);=0D=0A+=C2=A0=20=C2=A0=20case=20UFS_QUERY_ATTR_IDN=
_PINNED_WB_NUM_ALLOC_UNITS:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20retur=
n=20be32_to_cpu(u->attributes.pinned_wb_num_alloc_units);=0D=0A+=C2=A0=20=
=C2=A0=20case=20UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NUM_ALLOC_UNITS:=0D=0A=
+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20be32_to_cpu(u->attributes.non=
_pinned_wb_min_num_alloc_units);=0D=0A=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A=C2=
=A0=20=C2=A0=20=C2=A0return=200;=0D=0A=C2=A0=7D=0D=0A=40=40=20-1237,6=20+12=
97,9=20=40=40=20static=20QueryRespCode=20ufs_write_attr_value(UfsHc=20*u,=
=20uint8_t=20idn,=20uint32_t=20value)=0D=0A=C2=A0=20=C2=A0=20=C2=A0case=20U=
FS_QUERY_ATTR_IDN_PSA_DATA_SIZE:=0D=0A=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0u->attributes.psa_data_size=20=3D=20cpu_to_be32(value);=0D=0A=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0break;=0D=0A+=C2=A0=20=C2=A0=20case=20U=
FS_QUERY_ATTR_IDN_TIMESTAMP:=0D=0A+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20u->a=
ttributes.timestamp=20=3D=20cpu_to_be64(value);=0D=0A+=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20break;=0D=0A=C2=A0=20=C2=A0=20=C2=A0=7D=0D=0A=C2=A0=20=C2=A0=
=20=C2=A0return=20UFS_QUERY_RESULT_SUCCESS;=0D=0A=C2=A0=7D=0D=0Adiff=20--gi=
t=20a/include/block/ufs.h=20b/include/block/ufs.h=0D=0Aindex=2004cb24324d..=
4dacfb776f=20100644=0D=0A---=20a/include/block/ufs.h=0D=0A+++=20b/include/b=
lock/ufs.h=0D=0A=40=40=20-294,7=20+294,8=20=40=40=20typedef=20struct=20QEMU=
_PACKED=20DeviceDescriptor=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint32_t=20ps=
a_max_data_size;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20psa_state_timeout;=
=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20product_revision_level;=0D=0A-=C2=
=A0=20=C2=A0=20uint8_t=20reserved=5B36=5D;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=
=20reserved=5B34=5D;=0D=0A+=C2=A0=20=C2=A0=20uint16_t=20extended_wb_support=
;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint32_t=20extended_ufs_features_support;=0D=
=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20write_booster_buffer_preserve_user_spa=
ce_en;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20write_booster_buffer_type;=0D=
=0A=40=40=20-342,6=20+343,8=20=40=40=20typedef=20struct=20QEMU_PACKED=20Geo=
metryDescriptor=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20write_booster_=
buffer_cap_adj_fac;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20supported_write_=
booster_buffer_user_space_reduction_types;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uin=
t8_t=20supported_write_booster_buffer_types;=0D=0A+=C2=A0=20=C2=A0=20uint8_=
t=20reserved3=5B17=5D;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20cap_adj_fac_repres=
entation;=0D=0A=C2=A0=7D=20GeometryDescriptor;=0D=0A=0D=0A=C2=A0=23define=
=20UFS_GEOMETRY_CAPACITY_SHIFT=209=0D=0A=40=40=20-437,6=20+440,8=20=40=40=
=20typedef=20struct=20QEMU_PACKED=20Flags=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=
=A0uint8_t=20wb_buffer_flush_en;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20wb_=
buffer_flush_during_hibernate;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20reser=
ved4=5B2=5D;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20unpin_en;=0D=0A+=C2=A0=20=C2=
=A0=20uint8_t=20reserved5=5B235=5D;=0D=0A=C2=A0=7D=20Flags;=0D=0A=0D=0A=C2=
=A0typedef=20struct=20Attributes=20=7B=0D=0A=40=40=20-457,6=20+462,8=20=40=
=40=20typedef=20struct=20Attributes=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint=
16_t=20exception_event_status;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint32_t=20seco=
nds_passed;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint16_t=20context_conf;=0D=0A+=C2=
=A0=20=C2=A0=20uint8_t=20obsolete;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20reserv=
ed2=5B2=5D;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20device_ffu_status;=0D=0A=
=C2=A0=20=C2=A0=20=C2=A0uint8_t=20psa_state;=0D=0A=C2=A0=20=C2=A0=20=C2=A0u=
int32_t=20psa_data_size;=0D=0A=40=40=20-469,10=20+476,34=20=40=40=20typedef=
=20struct=20Attributes=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20availab=
le_wb_buffer_size;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20wb_buffer_life_ti=
me_est;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint32_t=20current_wb_buffer_size;=0D=
=0A+=C2=A0=20=C2=A0=20uint8_t=20reserved3=5B10=5D;=0D=0A+=C2=A0=20=C2=A0=20=
uint8_t=20ext_iid_en;=0D=0A+=C2=A0=20=C2=A0=20uint16_t=20host_hint_cache_si=
ze;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20refresh_status;=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0uint8_t=20refresh_freq;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=
=20refresh_unit;=0D=0A=C2=A0=20=C2=A0=20=C2=A0uint8_t=20refresh_method;=0D=
=0A+=C2=A0=20=C2=A0=20uint64_t=20timestamp;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=
=20reserved4=5B3=5D;=0D=0A+=C2=A0=20=C2=A0=20uint64_t=20device_level_except=
ion_id;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20defrag_op;=0D=0A+=C2=A0=20=C2=A0=
=20uint32_t=20hid_avail_size;=0D=0A+=C2=A0=20=C2=A0=20uint32_t=20hid_size;=
=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20hid_prog_ratio;=0D=0A+=C2=A0=20=C2=A0=20=
uint8_t=20hid_state;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20reserved5=5B2=5D;=0D=
=0A+=C2=A0=20=C2=A0=20uint8_t=20wb_buffer_resize_hint;=0D=0A+=C2=A0=20=C2=
=A0=20uint8_t=20wb_buffer_resize_en;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20wb_b=
uffer_resize_status;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20wb_buffer_partial_fl=
ush_mode;=0D=0A+=C2=A0=20=C2=A0=20uint32_t=20max_fifo_wb_partial_flush_mode=
;=0D=0A+=C2=A0=20=C2=A0=20uint32_t=20curr_fifo_wb_partial_flush_mode;=0D=0A=
+=C2=A0=20=C2=A0=20uint32_t=20pinned_wb_buffer_curr_alloc_units;=0D=0A+=C2=
=A0=20=C2=A0=20uint8_t=20pinned_wb_buffer_avail_percent;=0D=0A+=C2=A0=20=C2=
=A0=20uint32_t=20pinned_wb_cumm_written_size;=0D=0A+=C2=A0=20=C2=A0=20uint3=
2_t=20pinned_wb_num_alloc_units;=0D=0A+=C2=A0=20=C2=A0=20uint32_t=20non_pin=
ned_wb_min_num_alloc_units;=0D=0A+=C2=A0=20=C2=A0=20uint8_t=20reserved6=5B1=
84=5D;=0D=0A=C2=A0=7D=20Attributes;=0D=0A=0D=0A=C2=A0=23define=20UFS_TRANSA=
CTION_SPECIFIC_FIELD_SIZE=2020=0D=0A=40=40=20-856,6=20+887,7=20=40=40=20enu=
m=20flag_idn=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_FLAG_IDN_WB_BUFF_=
FLUSH_DURING_HIBERN8=20=3D=200x10,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_F=
LAG_IDN_HPB_RESET=20=3D=200x11,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_FLAG=
_IDN_HPB_EN=20=3D=200x12,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_FLAG_IDN_UNPIN_=
EN=20=3D=200x13,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_FLAG_IDN_COUNT,=0D=
=0A=C2=A0=7D;=0D=0A=0D=0A=40=40=20-893,9=20+925,29=20=40=40=20enum=20attr_i=
dn=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_ATTR_IDN_AVAIL_WB_BUFF_SIZE=
=20=3D=200x1D,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_ATTR_IDN_WB_BUFF_LIFE=
_TIME_EST=20=3D=200x1E,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_ATTR_IDN_CUR=
R_WB_BUFF_SIZE=20=3D=200x1F,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_EXT=
_IID_EN=20=3D=200x2A,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_HOST_HINT_=
CACHE_SIZE=20=3D=200x2B,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_ATTR_IDN_RE=
FRESH_STATUS=20=3D=200x2C,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_ATTR_IDN_=
REFRESH_FREQ=20=3D=200x2D,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_ATTR_IDN_=
REFRESH_UNIT=20=3D=200x2E,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_TIMES=
TAMP=20=3D=200x30,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_DEVICE_LEVEL_=
EXCEPTION_ID=20=3D=200x34,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_DEFRA=
G_OP=20=3D=200x35,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_HID_AVAIL_SIZ=
E=20=3D=200x36,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_HID_SIZE=20=3D=
=200x37,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_HID_PROG_RATIO=20=3D=20=
0x38,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_HID_STATE=20=3D=200x39,=0D=
=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_HINT=20=3D=200x3C,=
=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_EN=20=3D=200x3D,=
=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_WB_BUFF_RESIZE_STATUS=20=3D=200=
x3E,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_WB_BUFF_PARTIAL_FLUSH_MODE=
=20=3D=200x3F,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_MAX_FIFO_WB_PARTI=
AL_FLUSH_MODE=20=3D=200x40,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_CURR=
_FIFO_WB_PARTIAL_FLUSH_MODE=20=3D=200x41,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY=
_ATTR_IDN_PINNED_WB_BUFF_CURR_ALLOC_UNITS=20=3D=200x42,=0D=0A+=C2=A0=20=C2=
=A0=20UFS_QUERY_ATTR_IDN_PINNED_WB_BUFF_AVAIL_PERCENT=20=3D=200x43,=0D=0A+=
=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_PINNED_WB_CUMM_WRITTEN_SIZE=20=3D=200x=
44,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_PINNED_WB_NUM_ALLOC_UNITS=20=
=3D=200x45,=0D=0A+=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_IDN_NON_PINNED_WB_MIN_NU=
M_ALLOC_UNITS=20=3D=200x46,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_QUERY_ATTR_IDN=
_COUNT,=0D=0A=C2=A0=7D;=0D=0A=0D=0A=40=40=20-1005,6=20+1057,7=20=40=40=20en=
um=20device_desc_param=20=7B=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_DEVICE_DESC_P=
ARAM_PRDCT_REV=20=3D=200x2A,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_DEVICE_DESC_P=
ARAM_HPB_VER=20=3D=200x40,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_DEVICE_DESC_PAR=
AM_HPB_CONTROL=20=3D=200x42,=0D=0A+=C2=A0=20=C2=A0=20UFS_DEVICE_DESC_PARAM_=
EXT_WB_SUP=20=3D=200x4D,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_DEVICE_DESC_PARAM=
_EXT_UFS_FEATURE_SUP=20=3D=200x4F,=0D=0A=C2=A0=20=C2=A0=20=C2=A0UFS_DEVICE_=
DESC_PARAM_WB_PRESRV_USRSPC_EN=20=3D=200x53,=0D=0A=C2=A0=20=C2=A0=20=C2=A0U=
FS_DEVICE_DESC_PARAM_WB_TYPE=20=3D=200x54,=0D=0A=40=40=20-1208,14=20+1261,1=
4=20=40=40=20static=20inline=20void=20_ufs_check_size(void)=0D=0A=C2=A0=20=
=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(UfsMcqCqIntReg)=20=21=3D=2012);=0D=
=0A=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(UfsMcqOpReg)=20=21=3D=
=2048);=0D=0A=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(DeviceDescrip=
tor)=20=21=3D=2089);=0D=0A-=C2=A0=20=C2=A0=20QEMU_BUILD_BUG_ON(sizeof(Geome=
tryDescriptor)=20=21=3D=2087);=0D=0A+=C2=A0=20=C2=A0=20QEMU_BUILD_BUG_ON(si=
zeof(GeometryDescriptor)=20=21=3D=20105);=0D=0A=C2=A0=20=C2=A0=20=C2=A0QEMU=
_BUILD_BUG_ON(sizeof(UnitDescriptor)=20=21=3D=2045);=0D=0A=C2=A0=20=C2=A0=
=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(RpmbUnitDescriptor)=20=21=3D=2035);=0D=0A=
=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(PowerParametersDescriptor)=
=20=21=3D=2098);=0D=0A=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(Inte=
rconnectDescriptor)=20=21=3D=206);=0D=0A=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_=
BUG_ON(sizeof(StringDescriptor)=20=21=3D=20254);=0D=0A=C2=A0=20=C2=A0=20=C2=
=A0QEMU_BUILD_BUG_ON(sizeof(DeviceHealthDescriptor)=20=21=3D=2045);=0D=0A-=
=C2=A0=20=C2=A0=20QEMU_BUILD_BUG_ON(sizeof(Flags)=20=21=3D=200x13);=0D=0A+=
=C2=A0=20=C2=A0=20QEMU_BUILD_BUG_ON(sizeof(Flags)=20=21=3D=200xFF);=0D=0A=
=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(UtpUpiuHeader)=20=21=3D=20=
12);=0D=0A=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(UtpUpiuQuery)=20=
=21=3D=20276);=0D=0A=C2=A0=20=C2=A0=20=C2=A0QEMU_BUILD_BUG_ON(sizeof(UtpUpi=
uCmd)=20=21=3D=2020);=0D=0A--=0D=0A2.34.1

