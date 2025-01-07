Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8E01E77197
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2025 08:44:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tV5CG-0003jk-JX; Tue, 07 Jan 2025 03:44:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tV5CE-0003jP-NS
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:44:19 -0500
Received: from mailout1.samsung.com ([203.254.224.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1tV5C6-0008VZ-7y
 for qemu-devel@nongnu.org; Tue, 07 Jan 2025 03:44:18 -0500
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout1.samsung.com (KnoxPortal) with ESMTP id
 20250107084357epoutp01c1e91fd854fdfd6159a96bada791fa34~YXJHMCndD2624526245epoutp01k
 for <qemu-devel@nongnu.org>; Tue,  7 Jan 2025 08:43:57 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.samsung.com
 20250107084357epoutp01c1e91fd854fdfd6159a96bada791fa34~YXJHMCndD2624526245epoutp01k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1736239437;
 bh=qMVTTSrMbBxUY+BObY6KkjD7t/14XIBA7i8I9M0jDso=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=UJU7d0kTj8L1VYzqUCV5YSm01O4f2ElCRTIlqCtuSkacvEzwpFxTNizyc967V8mKT
 Nwwnac3yx8EE16/9uExVWGV60dBjY2mtJRLmIfPw1Wa6j4K4Y9/r7X0AtcRRUUVvyT
 SZOiqmafyA+X/Oz0w7rYKsPP6aW5o+wrgM3e/PTk=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTP id
 20250107084357epcas2p490bd9a8aa015af73bb28e7acab61acce~YXJG7FdYJ2756227562epcas2p44;
 Tue,  7 Jan 2025 08:43:57 +0000 (GMT)
Received: from epsmges2p3.samsung.com (unknown [182.195.36.69]) by
 epsnrtp1.localdomain (Postfix) with ESMTP id 4YS4Mw3ZpVz4x9Pr; Tue,  7 Jan
 2025 08:43:56 +0000 (GMT)
X-AuditID: b6c32a47-fd1c970000005659-12-677ce94ce160
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
 epsmges2p3.samsung.com (Symantec Messaging Gateway) with SMTP id
 CD.97.22105.C49EC776; Tue,  7 Jan 2025 17:43:56 +0900 (KST)
Mime-Version: 1.0
Subject: [PATCH v2] hw/ufs: Adjust value to match CPU's endian format
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, "philmd@linaro.org"
 <philmd@linaro.org>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
Date: Tue, 07 Jan 2025 17:43:56 +0900
X-CMS-MailID: 20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmphk+LIzCtJLcpLzFFi42LZdljTQtfnZU26wb3lEhYvD2lavH6xnNni
 /tZrjBafGqQs9m/7x2qxZoWwxfHeHSwO7B53ru1h83hybTOTx/t9V9k8+rasYvTYfLo6gDUq
 2yYjNTEltUghNS85PyUzL91WyTs43jne1MzAUNfQ0sJcSSEvMTfVVsnFJ0DXLTMH6AYlhbLE
 nFKgUEBicbGSvp1NUX5pSapCRn5xia1SakFKToF5gV5xYm5xaV66Xl5qiZWhgYGRKVBhQnZG
 /7xtzAW3hCqets5lbWB8JdjFyMkhIWAisbTrLVsXIxeHkMAORom7L28DORwcvAKCEn93CIPU
 CAu4Siz/vo0JxBYSUJLoWriVGSJuILFu+h4wm01AT2LK7zuMIHNEBBoZJbb13WAFcZhBnIsr
 PrNCbOOVmNH+lAXClpbYvnwrI4StIfFjWS8zhC0qcXP1W3YY+/2x+VA1IhKt985C1QhKPPi5
 mxHkUAkBSYmpPyQgwvUSre9PsYPslRCYwCjReOwP1Bx9iWsdG8H28gr4SvTf3Ak2h0VAVWLG
 gqNMEDUuEnd6esFsZgFtiWULXzODzGcW0JRYv0sfYpWyxJFbLBAVfBIdh/+yw3zVsPE3VvaO
 eU+gpqtJPFqwBRoKMhIX55xjnsCoNAsR0rOQ7J2FsHcBI/MqRrHUguLc9NRiowJjeOQm5+du
 YgQnRy33HYwz3n7QO8TIxMF4iFGCg1lJhDdLozJdiDclsbIqtSg/vqg0J7X4EKMp0McTmaVE
 k/OB6TmvJN7QxNLAxMzM0NzI1MBcSZz3XuvcFCGB9MSS1OzU1ILUIpg+Jg5OqQYm7YMhum/f
 tB2WdbXaxCDX9+fN9M6rfRZ/mqbZKVm88dDdLz7X7NlLX4Po07PXei9XVmg8IaD4rujZhm6u
 jBCZRpEPLw9P5ZAL69lQtk/zjKVds3JL7Ymd1YI704Q3L5lyx+pAwenpD18ZvrpY0bH/9ZZj
 180KPwh8es/LZFwho2npz2mmEqYx4cnD8rfW++zP7zJSSEhbyXSuNT7XhOPlx/uza1VTOT4F
 PpTZ9+st60wuZ3OjOZ+OXehYwuec1ih8qcpu6aTQXD4lg6u9ZhXP2YTv/tj4UPrnKbedLR82
 6eTP1tuS7WvQ/2tebmHhloSUfyl+qqy6Zux9PvZHP71zc1R7+zeO9eAMHt+KxRZKLMUZiYZa
 zEXFiQDw5Ck6FwQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3
References: <CGME20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
Received-SPF: pass client-ip=203.254.224.24;
 envelope-from=keosung.park@samsung.com; helo=mailout1.samsung.com
X-Spam_score_int: -47
X-Spam_score: -4.8
X-Spam_bar: ----
X-Spam_report: (-4.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Reply-To: keosung.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

In ufs_write_attr_value(), the value parameter is handled in the CPU's
endian format but provided in big-endian format by the caller. Thus, it
is converted to the CPU's endian format. The related test code is also
fixed to reflect this change.

Fixes: 7c85332a2b3e (=22hw/ufs: minor bug fixes related to ufs-test=22)
Reviewed-by: Philippe Mathieu-Daud=C3=A9=20<philmd=40linaro.org>=0D=0ASigne=
d-off-by:=20Keoseong=20Park=20<keosung.park=40samsung.com>=0D=0A---=0D=0A=
=20hw/ufs/ufs.c=20=20=20=20=20=20=20=20=20=20=20=7C=202=20+-=0D=0A=20tests/=
qtest/ufs-test.c=20=7C=202=20+-=0D=0A=202=20files=20changed,=202=20insertio=
ns(+),=202=20deletions(-)=0D=0A=0D=0Adiff=20--git=20a/hw/ufs/ufs.c=20b/hw/u=
fs/ufs.c=0D=0Aindex=208d26d13791..428fe927ad=20100644=0D=0A---=20a/hw/ufs/u=
fs.c=0D=0A+++=20b/hw/ufs/ufs.c=0D=0A=40=40=20-1164,7=20+1164,7=20=40=40=20s=
tatic=20QueryRespCode=20ufs_exec_query_attr(UfsRequest=20*req,=20int=20op)=
=0D=0A=20=20=20=20=20=20=20=20=20value=20=3D=20ufs_read_attr_value(u,=20idn=
);=0D=0A=20=20=20=20=20=20=20=20=20ret=20=3D=20UFS_QUERY_RESULT_SUCCESS;=0D=
=0A=20=20=20=20=20=7D=20else=20=7B=0D=0A-=20=20=20=20=20=20=20=20value=20=
=3D=20req->req_upiu.qr.value;=0D=0A+=20=20=20=20=20=20=20=20value=20=3D=20b=
e32_to_cpu(req->req_upiu.qr.value);=0D=0A=20=20=20=20=20=20=20=20=20ret=20=
=3D=20ufs_write_attr_value(u,=20idn,=20value);=0D=0A=20=20=20=20=20=7D=0D=
=0A=20=20=20=20=20req->rsp_upiu.qr.value=20=3D=20cpu_to_be32(value);=0D=0Ad=
iff=20--git=20a/tests/qtest/ufs-test.c=20b/tests/qtest/ufs-test.c=0D=0Ainde=
x=2060199abbee..1f860b41c0=20100644=0D=0A---=20a/tests/qtest/ufs-test.c=0D=
=0A+++=20b/tests/qtest/ufs-test.c=0D=0A=40=40=20-145,7=20+145,7=20=40=40=20=
static=20void=20ufs_send_query(QUfs=20*ufs,=20uint8_t=20slot,=20uint8_t=20q=
uery_function,=0D=0A=20=20=20=20=20req_upiu.qr.idn=20=3D=20idn;=0D=0A=20=20=
=20=20=20req_upiu.qr.index=20=3D=20index;=0D=0A=20=20=20=20=20req_upiu.qr.s=
elector=20=3D=20selector;=0D=0A-=20=20=20=20req_upiu.qr.value=20=3D=20attr_=
value;=0D=0A+=20=20=20=20req_upiu.qr.value=20=3D=20cpu_to_be32(attr_value);=
=0D=0A=20=20=20=20=20req_upiu.qr.length=20=3D=20UFS_QUERY_DESC_MAX_SIZE;=0D=
=0A=20=20=20=20=20qtest_memwrite(ufs->dev.bus->qts,=20req_upiu_addr,=20&req=
_upiu,=0D=0A=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20siz=
eof(req_upiu));=0D=0A--=20=0D=0A2.25.1=0D=0A=0D=0A

