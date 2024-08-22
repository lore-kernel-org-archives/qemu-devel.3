Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3AB4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2024 06:01:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sh0sH-00047a-GI; Thu, 22 Aug 2024 02:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh0s5-00046q-Gh
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 02:00:33 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yc01.jeong@samsung.com>)
 id 1sh0rz-0007oT-BH
 for qemu-devel@nongnu.org; Thu, 22 Aug 2024 02:00:33 -0400
Received: from epcas1p4.samsung.com (unknown [182.195.41.48])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20240822060011epoutp029ce4eb81fb9b481949eaf6dab858133c~t94uqwxuk1447414474epoutp02j
 for <qemu-devel@nongnu.org>; Thu, 22 Aug 2024 06:00:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20240822060011epoutp029ce4eb81fb9b481949eaf6dab858133c~t94uqwxuk1447414474epoutp02j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1724306411;
 bh=z5rfoUynf7keRCPtPSThpneVL/fJg6kMXtukxzACCyw=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=sv8QmWcmAG+ofUphRggCyz47pbEpyTt0m1xYXVYWXkd8hRSzcpn1wn+68AjhJWMmW
 FnGUewPqHWUm5Eg7Nx6VCuEgwTa3jH7GnxWBrgJMvesBVpaOSrPJO+Ks4lkk0IruMS
 /bgXFdcwpOyW1tNHXVHD2UsgRObh6OmCgKq3oKR8=
Received: from epsmgec1p1-new.samsung.com (unknown [182.195.42.76]) by
 epcas1p2.samsung.com (KnoxPortal) with ESMTP id
 20240822060011epcas1p282898f2d38a4dde799fa9f4560ffe749~t94uWfdsi1276712767epcas1p2g;
 Thu, 22 Aug 2024 06:00:11 +0000 (GMT)
X-AuditID: b6c32a4c-9ebcba8000004c35-4a-66c6d3eb2e16
Received: from epcas1p2.samsung.com ( [182.195.41.46]) by
 epsmgec1p1-new.samsung.com (Symantec Messaging Gateway) with SMTP id
 46.B8.19509.BE3D6C66; Thu, 22 Aug 2024 15:00:11 +0900 (KST)
Mime-Version: 1.0
Subject: Re: Re: [PATCH 1/4] hw/ufs: minor bug fixes related to ufs-test
From: Yoochan Jeong <yc01.jeong@samsung.com>
To: Jeuk Kim <jeuk20.kim@gmail.com>, Jeuk Kim <jeuk20.kim@samsung.com>
CC: "thuth@redhat.com" <thuth@redhat.com>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jeongyuchan0629@gmail.com"
 <jeongyuchan0629@gmail.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <c92844fd-8c4a-4ab6-b778-f8d8e86741eb@gmail.com>
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20240822060010epcms1p6b10addc94bc16411c3a32d1f404c5978@epcms1p6>
Date: Thu, 22 Aug 2024 15:00:10 +0900
X-CMS-MailID: 20240822060010epcms1p6b10addc94bc16411c3a32d1f404c5978
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
CMS-TYPE: 101P
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrJIsWRmVeSWpSXmKPExsWy7bCmnu7ry8fSDKbP5LToebWPzaLvyRwm
 i/tbrzFafGqQsti/7R+rxfHeHSwWK4/ZOLB77Jx1l93jybXNTB7v911l8+jbsooxgCWKyyYl
 NSezLLVI3y6BK6Ptxyv2grXlFZdOFjUwzijpYuTkkBAwkdg5Zz4jiC0ksIdRYvpE1i5GDg5e
 AUGJvzuEQcLCAh4SP9rfMUOUKEj8WH6TDSKuJ7F57Uw2kHI2AR2Jhp8OIGERATeJ3r/3wUqY
 BT4ySkz7KwCxiVdiRvtTFghbWmL78q1gWzkFbCWWLVrKChEXlbi5+i07jP3+GMRlEgIiEq33
 zjJD2IISD37uZgRZKyEgKbH+tSZEuF7ixrXHbBB2jcSjtltQY/QlrnVsBFvLK+ArsXDvVyYQ
 m0VAVWL76gVQa10kHjx+wQRxsrbEsoWvmUHGMwtoSqzfpQ8R5pN497WHFeaTHfOeMEHYKhKL
 Lr6HWisl8fXEOmaIyzwk9t9z7mLkAoZZD5PEsQ1fGCcwys9CBO0sJMtmISxbwMi8ilEqtaA4
 Nz012bDAUDcvtVyvODG3uDQvXS85P3cTIzh1aPnsYPy+/q/eIUYmDsZDjBIczEoivEn3jqYJ
 8aYkVlalFuXHF5XmpBYfYpTmYFES5z1zpSxVSCA9sSQ1OzW1ILUIJsvEwSnVwKTRPs+WS0d4
 g92C6xrn8jIf2nz95bpkt7X4kleVQlYanrP0llwIY1zN3KmjeDbojMmzS32uBrVPU/kqL9Tw
 T3fMUWT4Wf3O98R+EzfheTui7Pf85Eg4k5qr1S5w3+OxbudP/Qt3DyTrqyxruiY750F6mru1
 sQ2D+LNoM5+SZaXc2Tfu5iyboeeR4pT+t5lrJkPL/ldGdwrL5yjqiF/5rb3dM0qZRVc2ul6z
 z3XTpFdrtgUeeigpPu+J0oSHr1cwHgsz/zTlNMuqxQoXEnJ2pNztjGycPUNz/axbnEmmBqa5
 CdUGrh6M310mlez1ftFw5eWRV6efqc1pUk+92tJfczE1L1PNKvegzGq38k0CSizFGYmGWsxF
 xYkAqnlRxYwDAAA=
X-CMS-RootMailID: 20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10
References: <c92844fd-8c4a-4ab6-b778-f8d8e86741eb@gmail.com>
 <20240821023025epcms1p4de36db95f4d3a66727f128ef6be860e4@epcms1p4>
 <20240821023245epcms1p31ada9c24041d9b34f7e9938abe93189b@epcms1p3>
 <CGME20240821022726epcms1p127d8cd71ca3e1354592de8a4a5c97a10@epcms1p6>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=yc01.jeong@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.138,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Reply-To: yc01.jeong@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 8/22/2024, Jeuk Kim wrote:
> On 8/21/2024 11:32 AM, =EC=A0=95=EC=9C=A0=EC=B0=AC=20wrote:=0D=0A>>=C2=A0=
=20From=20d0ae8e25aec4ae7d222a2ea667d5ddb61f14fe02=20Mon=20Sep=2017=2000:00=
:00=202001=0D=0A>>=20From:=20Yoochan=20Jeong=20<yc01.jeong=40samsung.com>=
=0D=0A>>=20Date:=20Wed,=2021=20Aug=202024=2009:03:06=20+0900=0D=0A>>=20Subj=
ect:=20=5BPATCH=201/4=5D=20hw/ufs:=20minor=20bug=20fixes=20related=20to=20u=
fs-test=0D=0A>>=0D=0A>>=20Minor=20bugs=20and=20errors=20related=20to=20ufs-=
test=20are=20resolved.=20Some=0D=0A>>=20permissions=20and=20code=20implemen=
tations=20that=20are=20not=20synchronized=0D=0A>>=20with=20the=20ufs=20spec=
=20are=20edited.=0D=0A>>=0D=0A>>=20Based=20on:=2020240802051902epcms2p319bc=
095a15eaef8de4e6955f6718371d=40epcms2p3=0D=0A>>=20Signed-off-by:=20Yoochan=
=20Jeong=20<yc01.jeong=40samsung.com>=0D=0A>>=20---=0D=0A>>=C2=A0=20hw/ufs/=
ufs.c=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=2026=20++++++++++++++++++++=
+-----=0D=0A>>=C2=A0=20tests/qtest/ufs-test.c=2012=20+++++++++---=0D=0A>>=
=C2=A0=202=20files=20changed,=2030=20insertions(+),=208=20deletions(-)=0D=
=0A>>=0D=0A>>=20diff=20--git=20a/hw/ufs/ufs.c=20b/hw/ufs/ufs.c=0D=0A>>=20in=
dex=20ce2c96aeea..9472a3c14a=20100644=0D=0A>>=20---=20a/hw/ufs/ufs.c=0D=0A>=
>=20+++=20b/hw/ufs/ufs.c=0D=0A>>=20=40=40=20-971,7=20+971,7=20=40=40=20stat=
ic=20const=20int=20attr_permission=5BUFS_QUERY_ATTR_IDN_COUNT=5D=20=3D=20=
=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20UFS_QUERY_ATTR_READ=
=20UFS_QUERY_ATTR_WRITE,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATT=
R_IDN_EE_STATUS=5D=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A>>=C2=A0=20=C2=A0=20=
=C2=A0=20=5BUFS_QUERY_ATTR_IDN_SECONDS_PASSED=5D=20=3D=20UFS_QUERY_ATTR_WRI=
TE,=0D=0A>>=20-=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_CNTX_CONF=5D=20=3D=
=20UFS_QUERY_ATTR_READ,=0D=0A>>=20+=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_=
CNTX_CONF=5D=20=3D=20UFS_QUERY_ATTR_READ=20UFS_QUERY_ATTR_WRITE,=0D=0A>=20=
=0D=0A>=20Although=20the=20spec=20defines=20UFS_QUERY_ATTR_IDN_CNTX_CONF=20=
as=20configurable,=0D=0A>=20the=20qemu=20ufs=20does=20not=20yet=20implement=
=20related=20functionality.=0D=0A>=20So=20it=20seems=20reasonable=20to=20le=
ave=20it=20as=20not=20configurable=20to=20me.=0D=0A>=0D=0A=0D=0AOkay.=20Som=
e=20testcases=20in=20patch=203/4=20also=20involve=20this=20attribute,=0D=0A=
so=20I=20will=20also=20edit=20them=20in=20the=20next=20version.=0D=0A=0D=0A=
>=20=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_FFU_STATUS=5D=
=20=3D=20UFS_QUERY_ATTR_READ,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=5BUFS_QUER=
Y_ATTR_IDN_PSA_STATE=5D=20=3D=20UFS_QUERY_ATTR_READ=20UFS_QUERY_ATTR_WRITE,=
=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=5BUFS_QUERY_ATTR_IDN_PSA_DATA_SIZE=5D=
=20=3D=0D=0A>>=20=40=40=20-1038,7=20+1038,7=20=40=40=20static=20QueryRespCo=
de=20ufs_exec_query_flag(UfsRequest=20*req,=20int=20op)=0D=0A>>=C2=A0=20=C2=
=A0=20=C2=A0=20=7D=0D=0A>>=C2=A0=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20*(((uint=
8_t=20*)&u->flags)=20+=20idn)=20=3D=20value;=0D=0A>>=20-=C2=A0=20=C2=A0=20r=
eq->rsp_upiu.qr.value=20=3D=20cpu_to_be32(value);=0D=0A>>=20+=C2=A0=20=C2=
=A0=20req->rsp_upiu.qr.value=20=3D=20value;=0D=0A>=20=0D=0A>=20req->rsp_upi=
u.qr.value=20uses=20big=20endian.=20Please=20check=20the=20spec=0D=0A=0D=0A=
It=20seems=20that=20the=20original=20code=20is=20correct,=20sorry=20for=20t=
he=20confusion.=0D=0AI=20will=20edit=20some=20testcases=20in=20test=20funct=
ions=20to=20check=20be32_to_cpu=20values.=0D=0A=0D=0A>=20=0D=0A>=20=0D=0A>>=
=C2=A0=20=C2=A0=20=C2=A0=20return=20UFS_QUERY_RESULT_SUCCESS;=0D=0A>>=C2=A0=
=20=7D=0D=0A>>=C2=A0=0D=0A>>=20=40=40=20-1148,8=20+1148,11=20=40=40=20stati=
c=20QueryRespCode=20ufs_exec_query_attr(UfsRequest=20*req,=20int=20op)=0D=
=0A>>=C2=A0=20=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20UfsHc=20*u=20=3D=20req-=
>hc;=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20uint8_t=20idn=20=3D=20req->req_upiu.=
qr.idn;=0D=0A>>=20+=C2=A0=20=C2=A0=20uint8_t=20selector=20=3D=20req->req_up=
iu.qr.selector;=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20uint32_t=20value;=0D=0A>>=
=C2=A0=20=C2=A0=20=C2=A0=20QueryRespCode=20ret;=0D=0A>>=20+=C2=A0=20=C2=A0=
=20const=20uint8_t=20UFS_QUERY_ATTR_CNTX_CONF_SELECTOR=20=3D=2015;=0D=0A>>=
=20+=C2=A0=20=C2=A0=20const=20uint32_t=20UFS_QUERY_ATTR_MAXVALUE=20=3D=200x=
0F;=0D=0A>=20The=20name=20UFS_QUERY_ATTR_MAXVALUE=20does=20not=20seem=20app=
ropriate.=20Rename=20it=20to=0D=0A>=20mean=20the=20maximum=20value=20of=20t=
he=20ICC.=0D=0A=0D=0AI=20named=20it=20this=20way=20because=20CNTX_CONF=20at=
tribute=20also=20had=20the=20same=20range.=0D=0ABut=20since=20that=20attrib=
ute=20is=20not=20writable=20now,=20it=20seems=20that=20changing=20its=0D=0A=
name=20including=20ICC=20would=20be=20better.=0D=0AAlso,=20I=20will=20move=
=20this=20constant=20to=20ufs.h=20file.=0D=0A=0D=0A>>=C2=A0=0D=0A>>=C2=A0=
=20=C2=A0=20=C2=A0=20ret=20=3D=20ufs_attr_check_idn_valid(idn,=20op);=0D=0A=
>>=C2=A0=20=C2=A0=20=C2=A0=20if=20(ret)=20=7B=0D=0A>>=20=40=40=20-1159,10=
=20+1162,20=20=40=40=20static=20QueryRespCode=20ufs_exec_query_attr(UfsRequ=
est=20*req,=20int=20op)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20if=20(op=20=3D=3D=
=20UFS_QUERY_ATTR_READ)=20=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20value=20=3D=20ufs_read_attr_value(u,=20idn);=0D=0A>>=C2=A0=20=C2=
=A0=20=C2=A0=20=7D=20else=20=7B=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20value=20=3D=20be32_to_cpu(req->req_upiu.qr.value);=0D=0A>>=20+=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20value=20=3D=20req->req_upiu.qr.value;=0D=0A>>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(idn=20=3D=3D=20UFS_QUERY_ATTR=
_IDN_ACTIVE_ICC_LVL=20&&=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20value=20>=20UFS_QUERY_ATTR_MAXVALUE)=20=7B=0D=0A>=20Move=20t=
his=20condition=20check=20inside=20the=20ufs_write_attr_value()=20function=
=0D=0A=0D=0AI=20will=20change=20ufs_write_attr_value=20to=20return=20QueryR=
espCode=20and=0D=0Aedit=20this=20function=20slightly.=0D=0A=0D=0A>>=20+=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20UFS_QUERY_RESUL=
T_INVALID_VALUE;=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20if=20(idn=20=3D=3D=20UFS_QUERY_ATTR=
_IDN_CNTX_CONF)=20=7B=0D=0A>=20Remove=20it.=20We=20haven't=20implemented=20=
the=20UFS_QUERY_ATTR_IDN_CNTX_CONF=0D=0A>=20function=20yet.=0D=0A=0D=0AI=20=
will=20edit=20it=20that=20way.=0D=0A=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20if=20(selector=20=21=3D=20UFS_QUERY_ATTR_CNTX_CO=
NF_SELECTOR)=20=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20return=20UFS_QUERY_RESULT_INVALID_SELECTOR;=0D=
=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=20else=
=20if=20(value=20=3D=3D=200x00=20value=20>=20UFS_QUERY_ATTR_MAXVALUE)=20=7B=
=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20return=20UFS_QUERY_RESULT_INVALID_VALUE;=0D=0A>>=20+=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=7D=0D=0A>>=20+=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=7D=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20u=
fs_write_attr_value(u,=20idn,=20value);=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=
=7D=0D=0A>>=20-=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20req->rsp_upiu.qr.value=20=
=3D=20cpu_to_be32(value);=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20return=20UFS_QU=
ERY_RESULT_SUCCESS;=0D=0A>>=C2=A0=20=7D=0D=0A>>=20=40=40=20-1287,9=20+1300,=
12=20=40=40=20static=20QueryRespCode=20ufs_read_desc(UfsRequest=20*req)=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20UfsHc=20*u=20=3D=20req->hc;=0D=0A>>=C2=A0=
=20=C2=A0=20=C2=A0=20QueryRespCode=20status;=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20uint8_t=20idn=20=3D=20req->req_upiu.qr.idn;=0D=0A>>=20+=C2=A0=20=C2=
=A0=20uint8_t=20selector=20=3D=20req->req_upiu.qr.selector;=0D=0A>>=C2=A0=
=20=C2=A0=20=C2=A0=20uint16_t=20length=20=3D=20be16_to_cpu(req->req_upiu.qr=
.length);=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20InterconnectDescriptor=20desc;=
=0D=0A>>=20-=0D=0A>>=20+=C2=A0=20=C2=A0=20if=20(selector=20=21=3D=200)=20=
=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20return=20UFS_QUERY_RESUL=
T_INVALID_SELECTOR;=0D=0A>>=20+=C2=A0=20=C2=A0=20=7D=0D=0A>>=C2=A0=20=C2=A0=
=20=C2=A0=20switch=20(idn)=20=7B=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20case=20U=
FS_QUERY_DESC_IDN_DEVICE:=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20memcpy(&req->rsp_upiu.qr.data,=20&u->device_desc,=20sizeof(u->device_des=
c));=0D=0A>>=20diff=20--git=20a/tests/qtest/ufs-test.c=20b/tests/qtest/ufs-=
test.c=0D=0A>>=20index=2082ec3f0671..d70c2ee4a3=20100644=0D=0A>>=20---=20a/=
tests/qtest/ufs-test.c=0D=0A>>=20+++=20b/tests/qtest/ufs-test.c=0D=0A>>=20=
=40=40=20-119,8=20+119,10=20=40=40=20static=20void=20ufs_send_nop_out(QUfs=
=20*ufs,=20uint8_t=20slot,=0D=0A>>=C2=A0=0D=0A>>=C2=A0=20static=20void=20uf=
s_send_query(QUfs=20*ufs,=20uint8_t=20slot,=20uint8_t=20query_function,=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20uint8_t=
=20query_opcode,=20uint8_t=20idn,=20uint8_t=20index,=0D=0A>>=20+=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20uint8_t=20selector,=20uint32_t=20attr_valu=
e,=0D=0A>=20=0D=0A>=20We=20use=20ufs_send_query()=20not=20only=20for=20attr=
ibutes,=20but=20also=20descriptors=0D=0A>=20and=20flags.=0D=0A>=20=0D=0A>=
=20Please=20rename=20=60attr_value=60=20to=20=60value=60.=0D=0A>=20=0D=0A>=
=0D=0A=20=0D=0AI=20think=20this=20parameter=20name=20is=20okay,=20because=
=20this=20=22value=22=20in=20UPIU=20is=0D=0Aonly=20used=20when=20writing=20=
attributes.=20Writing=20flags=20do=20not=20require=20an=0D=0Aactual=20value=
,=20and=20descriptor=20data=20will=20be=20stored=20in=20data=20segmentation=
=0D=0Aarea.=0D=0A=20=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20UtpTransferReqDesc=20*utrd_out,=20UtpUpiuRsp=20*rsp_out)=0D=
=0A>>=C2=A0=20=7B=0D=0A>>=20+=C2=A0=20=C2=A0=20const=20uint16_t=20UFS_QUERY=
_DESC_MAXLENGTH=20=3D=200x62;=0D=0A>=20How=20did=20you=20determine=20that=
=20the=20maximum=20size=20of=20a=20descriptor=20is=2062?=0D=0A=0D=0AIt=20wo=
uld=20be=20better=20to=20use=20UFS_QUERY_DESC_MAX_SIZE=20in=20ufs.h.=0D=0AI=
=20will=20edit=20it=20that=20way.=0D=0A=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20/=
*=20Build=20up=20utp=20transfer=20request=20descriptor=20*/=0D=0A>>=C2=A0=
=20=C2=A0=20=C2=A0=20UtpTransferReqDesc=20utrd=20=3D=20ufs_build_req_utrd(u=
fs->cmd_desc_addr,=20slot,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20UFS_UTP_NO_DATA_TRANSFER,=200)=
;=0D=0A>>=20=40=40=20-136,13=20+138,16=20=40=40=20static=20void=20ufs_send_=
query(QUfs=20*ufs,=20uint8_t=20slot,=20uint8_t=20query_function,=0D=0A>>=C2=
=A0=20=C2=A0=20=C2=A0=20req_upiu.header.query_func=20=3D=20query_function;=
=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20req_upiu.header.task_tag=20=3D=20slot;=
=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20/*=0D=0A>>=20-=C2=A0=20=C2=A0=20*=20QEMU=
=20UFS=20does=20not=20currently=20support=20Write=20descriptor=20and=20Writ=
e=20attribute,=0D=0A>>=20+=C2=A0=20=C2=A0=20*=20QEMU=20UFS=20does=20not=20c=
urrently=20support=20Write=20descriptor,=0D=0A>=20=0D=0A>=20We=20might=20ne=
ed=20to=20check=20condition=20here=20that=20=60query_opcode=20=21=3D=0D=0A>=
=20UFS_UPIU_QUERY_OPCODE_WRITE_DESC=60,=20since=0D=0A>=20=0D=0A>=20it=20is=
=20not=20implemented=20yet.=0D=0A>=20=0D=0A=0D=0Ain=20ufs_exec_query_write=
=20function=20in=20ufs.c,=20it=20already=20checks=0D=0Aif=20it=20is=20tryin=
g=20to=20write=20a=20descriptor.=20Is=20there=20any=20particular=0D=0Areaso=
n=20that=20we=20should=20check=20it=20here=20in=20advance?=0D=0A=0D=0A>>=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*=20so=20the=20value=20of=20data_segment_l=
ength=20is=20always=200.=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20*/=0D=
=0A>>=C2=A0=20=C2=A0=20=C2=A0=20req_upiu.header.data_segment_length=20=3D=
=200;=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20req_upiu.qr.opcode=20=3D=20query_op=
code;=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20req_upiu.qr.idn=20=3D=20idn;=0D=0A>=
>=C2=A0=20=C2=A0=20=C2=A0=20req_upiu.qr.index=20=3D=20index;=0D=0A>>=20+=C2=
=A0=20=C2=A0=20req_upiu.qr.selector=20=3D=20selector;=0D=0A>>=20+=C2=A0=20=
=C2=A0=20req_upiu.qr.value=20=3D=20attr_value;=0D=0A>>=20+=C2=A0=20=C2=A0=
=20req_upiu.qr.length=20=3D=20UFS_QUERY_DESC_MAXLENGTH;=0D=0A>>=C2=A0=20=C2=
=A0=20=C2=A0=20qtest_memwrite(ufs->dev.bus->qts,=20req_upiu_addr,=20&req_up=
iu,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20sizeof(req_upiu));=0D=0A>>=C2=A0=0D=0A>=
>=20=40=40=20-344,7=20+349,7=20=40=40=20static=20void=20ufs_init(QUfs=20*uf=
s,=20QGuestAllocator=20*alloc)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20/*=20Set=
=20fDeviceInit=20flag=20via=20query=20request=20*/=0D=0A>>=C2=A0=20=C2=A0=
=20=C2=A0=20ufs_send_query(ufs,=200,=20UFS_UPIU_QUERY_FUNC_STANDARD_WRITE_R=
EQUEST,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20UFS_UPIU_QUERY_OPCODE_SET_FLAG,=0D=
=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20UFS_QUERY_FLAG_IDN_FDEVICEINIT,=200,=20&utrd,=20&rsp_upiu);=
=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20UFS_QUERY_FLAG_IDN_FDEVICEINIT,=200,=200,=200,=20&utrd,=
=20&rsp_upiu);=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20g_assert_cmpuint(le32_to_c=
pu(utrd.header.dword_2),=20=3D=3D,=20UFS_OCS_SUCCESS);=0D=0A>>=C2=A0=0D=0A>=
>=C2=A0=20=C2=A0=20=C2=A0=20/*=20Wait=20for=20device=20to=20reset=20*/=0D=
=0A>>=20=40=40=20-353,7=20+358,8=20=40=40=20static=20void=20ufs_init(QUfs=
=20*ufs,=20QGuestAllocator=20*alloc)=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20=C2=A0=20qtest_clock_step(ufs->dev.bus->qts,=20100);=0D=0A>>=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20ufs_send_query(ufs,=200,=20UFS_UPIU_QUE=
RY_FUNC_STANDARD_READ_REQUEST,=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20UFS_UPIU_QUERY_OPCODE_READ_FLAG,=0D=0A>>=20-=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=
UFS_QUERY_FLAG_IDN_FDEVICEINIT,=200,=20&utrd,=20&rsp_upiu);=0D=0A>>=20+=C2=
=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20UFS_QUERY_FLAG_IDN_FDEVICEINIT,=200,=200,=200,=20&utrd=
,=0D=0A>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20&rsp_upiu);=0D=0A>>=C2=A0=20=C2=A0=
=20=C2=A0=20=7D=20while=20(be32_to_cpu(rsp_upiu.qr.value)=20=21=3D=200=20&&=
=0D=0A>>=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20g_get_monotonic_time()=20<=20end_time);=0D=0A>>=C2=A0=20=C2=A0=20=C2=
=A0=20g_assert_cmpuint(be32_to_cpu(rsp_upiu.qr.value),=20=3D=3D,=200);

