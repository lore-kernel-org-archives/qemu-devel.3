Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E38EC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 10:59:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roi31-0001QQ-3C; Mon, 25 Mar 2024 06:59:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1roi30-0001QI-1p
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:59:22 -0400
Received: from mail-bn8nam04on2078.outbound.protection.outlook.com
 ([40.107.100.78] helo=NAM04-BN8-obe.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <yajunw@nvidia.com>) id 1roi2y-0003Qu-1S
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 06:59:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gUYz9BT7THaAQs4NEYa9chHCTZFgIlwpIPmQb2YifxbSccQX38HKSxVCZQJzYq8G8OjPXtSnBbODfysNdWX4wZzVKXJz2D2u8he6O4faxsQfse37WpDsC3LlUtRyO0ttgv422vNTUir3bfK0lrBJo26gpNvl5VFli5xjm7km9fdNLiw984e5tHAgFFQmCMaRwyKqjE378NiKwB1yaJrKeyVD+U8U2SvaNfWPco6kGS214KsmL70gNbAu8WPqJxbriMXEsFMbR2XWPeNgHKLtOiIBEFkEJ46rb7FGqqLCsfUDidnQ6nFQGvxfVu2L3lHa4mWwCljae37hMqp3dUDjcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+/Y7DGafFJAyPSe7tNqymVzlCfDRyoAmBJszyZMWzo=;
 b=SMz4p5vmg7OTfU0R9i3Ap4j++wlSsAMLJT3O/NB5c9N2NwHf79ALzm/4KZleZX5CyBypVYiM7R7TC0FsPWPtx/Aag7f64R6zpwlR+rtuXm9NQaLXQ7kop2pU9VWGahaiKuv6Ga8C9nd1KQ5yaHMG2f3eyBxlm7xjKKNVttOngm+9MJW4mcC/WhmP23pxmtkaPb8P2qsymPfwwdkLWHj3qlyla8Oz6Njxa/D0nzIkYrgTIYWO/npKiO6FQNNd3mEytACaYrrqVES2HVj+QJhdZ92+ttdok8wCHbUF1h8fFGuzQWYaDiojzeQdkHMZvHgs3ZU7R6TMCOqvoZTF+OZp/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+/Y7DGafFJAyPSe7tNqymVzlCfDRyoAmBJszyZMWzo=;
 b=SfksOg3LES+JIAGh1Ea3/M8owwT+z7aFUOJvyNGlD0mYV73mnj0kNDolFYlBXdvlNhwKVGECkJzKAl9BX/k+XX7dD3buLjE8YxIoMW/yUsAqL5Jmyfh1oNEV0NGs4Qw4bzGs5J7FO4VIZW2HfkDVVP1Spbz9ICQWxfeQPUxJ+XEBF6dGu8/SdWeF1bjT/zISpHrj0vOcQZLhP/NUQrRXnYCB6YGZcwGxWi8n1MXCWmvPTSI3ictNiV4+H6XtWt+cX3wXwrqp4rDBy+I/HjzccWUPoH/BLGEbjGwIOCdxczkIgpKb5lEnqqP7qpCmKcnSdYb6J76qk/N9ydLasWNg1w==
Received: from DM4PR12MB5168.namprd12.prod.outlook.com (2603:10b6:5:397::8) by
 DS0PR12MB6463.namprd12.prod.outlook.com (2603:10b6:8:c5::10) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.31; Mon, 25 Mar 2024 10:54:13 +0000
Received: from DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824]) by DM4PR12MB5168.namprd12.prod.outlook.com
 ([fe80::449b:329d:c9cd:5824%5]) with mapi id 15.20.7409.031; Mon, 25 Mar 2024
 10:54:13 +0000
From: Yajun Wu <yajunw@nvidia.com>
To: "fengli@smartx.com" <fengli@smartx.com>, "raphael.norwitz@nutanix.com"
 <raphael.norwitz@nutanix.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "mst@redhat.com" <mst@redhat.com>, Parav Pandit <parav@nvidia.com>
Subject: vhost-user-blk  reconnect issue
Thread-Topic: vhost-user-blk  reconnect issue
Thread-Index: Adp+nnkoENmPBEsIQVaXjBYKlOa4yg==
Date: Mon, 25 Mar 2024 10:54:13 +0000
Message-ID: <DM4PR12MB5168C0DB5E4B8F30B47738F6B6362@DM4PR12MB5168.namprd12.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR12MB5168:EE_|DS0PR12MB6463:EE_
x-ms-office365-filtering-correlation-id: c8854b63-d7ec-4192-d9f8-08dc4cb9e879
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kvuCCnMhYH2WLubLMMYpMK8VeFvhsxFrFQ8gY018Xysh8wsnh1ahsW9QFnlZvYTcDlb/kmuRWq8AtlRbSzx9dmPtIeqLtnrUPMNYKN0yblSxcU11yngU0UUXwq8uA9LCjngAeihvjVVLmYXoy0PGudB9kGF85soSsFaFunxmub8f5IjQLnmm/bnjfj4RceJQgy+Ow3iTJanPKI2h6/Lnlg47VsaaRQP9P8uWMfsag0YKuX29WQDj5kdM4OfIyoMQFdQFbJXJ1wq2TnU4FHGBUhdpV6f6Bm2yfPzfjrCAS7c8dJ7XnhWSf/0BaHGMGZOVNcuY3E685UNvcJd5/N4uAQ6A9WBNL7mm5TuHcAOdQHz6sgX1H6Ky9oXKvZ0VeWzOtNW654iZluDdb/HDGZ3CLKOM1VwX3P4GIO+cs6q6+jXbtPORIIOV7/gf4gjzfH4e+bJvq0W8yAmvAg+XzPOnMeMGOL6USOAD96yNzLRnGnQBH+BQbhHtB04/Km53QnMTpWznqAlzn40pMbexCsX59foSLvNiVpkH/3nB/4H5X+B2feHVqvihO1JtuJrcMvgAAq8p8wtvVCJqVDVyi7XMQ6IJEml5hq4DkAulEgAA7ZSyNrJ8F9jxHZBHMN0TjRSQX7zGjAkA8sORLidjnHbKB4knDLMhrL3yZAkc7UbBAEH8ivC49DQGQkgx51VQKk/Epuz8W5WK7YWr/h087PY+Ag==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5168.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230031)(376005)(1800799015)(366007)(38070700009); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FqI+/eWwzjd3nG7jNrhnBxQW5hcrZNbGP6w0rmmMriuWYgzL5DsAxkXoyg/2?=
 =?us-ascii?Q?YMD0R4w/W7ThDakt+bRmxmdUmocywmz44GOWhFYATHnx+zLcGxDf6j27I3/G?=
 =?us-ascii?Q?Uf7Kq9kGpEmb8gdmLjnIOyPGbOC0s0sIGycHnjyhLSVvfKUjaPPGqKnBpvoJ?=
 =?us-ascii?Q?igzdaDwnqgj0GQJhkbiA3LK2A7PZklIvbszUxb5fvIuCvcDb4OghzjwMcntl?=
 =?us-ascii?Q?TyuWEpo+hoEi5btzRQR02EbjOOW6B7iqXSGQV0C7RwVqDJZP8mEizzStKQ+T?=
 =?us-ascii?Q?PZUP3Vhxfvx1pritcOjNK6a1o3z9Mqy/qxdwOX/olmKv+0XeVRTl3u//b0Rm?=
 =?us-ascii?Q?2rI0oACGHKmZ8iJvoiC0tRISFXLxAfrm+joeJkFBTsuvwgaIUD/xCgnK9U7K?=
 =?us-ascii?Q?qZ2PTw3OCE5StZDNkqRxtfEQS0d3umb6gXtJb5ka8lQpu7gDMG5D1csw138Z?=
 =?us-ascii?Q?15FijyCfobIA+Mgmu5fjVxNw6RSwQmjGWhs0/hwPxauaJmrnFy8eXBCXssc+?=
 =?us-ascii?Q?mdKBcvj8LsS5ySn4sHPGt59h10fBAs+jKanPzktKIL55c88d6i8pmbjshqUJ?=
 =?us-ascii?Q?eO00loLeSRgI11goZoa4UyX692jrhugT4ecGUrzmBrpyMTq9hXq0DCzmFlnu?=
 =?us-ascii?Q?B/8Dwp2CAxCWc0bqqZD0QXtjU/ielf6eG9x7MdOdswX1r4Wo0SYhFJdQDGhZ?=
 =?us-ascii?Q?yG6NZd0fR9fWsQl+RsP4h7KhuHuu4Wdbi42NB0Ttq5+gO6jlgYrnYT3yqDio?=
 =?us-ascii?Q?dYLX387lGsm3ABwISDmYgXy/FM20ntxYMVVFWce+XNJmxx4KO0J9X3ieta3a?=
 =?us-ascii?Q?6HhY8HwZWATbbaTdNpf+kp4TF/mEd0CkLpP1qADsRdke2+CFMmdNNJUZd+kZ?=
 =?us-ascii?Q?hzBJjRtMsn+AyZ3OEGPWpDE3V3bJ8nVMbnMP4YiJswXQFhqUnpAhNquFNyao?=
 =?us-ascii?Q?FRD+3L5hmStNZnIKlUSWvXoCzvNNs4WQZ3PW31KkmI6r4m2IEVaTmXfrjF59?=
 =?us-ascii?Q?tgCEnrfasF0ekJNmgiBMkgWfImKrcPJ8HM8rTUKLxwCyo3219tR/XPOkmpCA?=
 =?us-ascii?Q?OAv8gRhLX8tWMAigglXlr5Y7QaAXg6Gj0Fp5eqYCB3gdcwgPxWx+oxf/sEKV?=
 =?us-ascii?Q?xBPbElaSMfqYPqfOrpcyyeWFZozayh7AeV7WgwIXapbqLANwxqsj9plVc1ft?=
 =?us-ascii?Q?ePM8Aw1Zou7ZCJly4/GTv0EALg39k8fhxBL+ZAAQqIptN0FeyiIvuzldqF1V?=
 =?us-ascii?Q?Ry3skpJk1mPH4r5xT4FdTeLjGna4OUwuyIGLDQh7MiPZrGx0p5jCgCce5BQW?=
 =?us-ascii?Q?/dnUCIb+wwP4/F6NufAwmQvIic9YsTioBRjGl46BcFYgwAz3y3phj+CwjgJv?=
 =?us-ascii?Q?okrIepWPHGzCHV+/O7s8wHPfny0BFS6taKJw7GCX1NcHoHQTLLtUlIDBdmJh?=
 =?us-ascii?Q?3kroxRHlEMKI4zV7kBb8uU0rrX67Py6tn3dGtdnd5PAKujh8e4zHvzkd4vQC?=
 =?us-ascii?Q?6bb+B83Nav8098YCZpjTe7fiKyfQ3I6wSNjsk47Mr7JOX+itQZ3IkEPYM42U?=
 =?us-ascii?Q?D5HHuSDciPi8rzw5K5E=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5168.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c8854b63-d7ec-4192-d9f8-08dc4cb9e879
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2024 10:54:13.2689 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XVxwuAkklgAv3GxkqF/e8F1aTfOvjZCLarrSxuFhLnIaGBonxEi05rC6up0kKBRtgO+UgXLRFDRXjlryDE+Rtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6463
Received-SPF: softfail client-ip=40.107.100.78; envelope-from=yajunw@nvidia.com;
 helo=NAM04-BN8-obe.outbound.protection.outlook.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi experts,

With latest QEMU (8.2.90), we find two vhost-user-blk backend reconnect fai=
lure scenarios:
1. Disconnect vhost-user-blk backend before guest driver probe vblk device,=
 then reconnect backend after guest driver probe device. QEMU won't send ou=
t any vhost messages to restore backend.
This is because vhost->vdev is NULL before guest driver probe vblk device, =
so vhost_user_blk_disconnect won't be called, s->connected is still true. N=
ext vhost_user_blk_connect will simply return without doing anything.

2. modprobe -r virtio-blk inside VM, then disconnect backend, then reconnec=
t backend, then modprobe virtio-blk. QEMU won't send messages in vhost_dev_=
init.=20
This is because rmmod will let qemu call vhost_user_blk_stop, vhost->vdev a=
lso become NULL(in vhost_dev_stop), vhost_user_blk_disconnect won't be call=
ed. Again s->connected is still true, even chr connect is closed.

I think even vhost->vdev is NULL, vhost_user_blk_disconnect should be calle=
d when chr connect close?
Hope we can have a fix soon.


Thanks,
Yajun

