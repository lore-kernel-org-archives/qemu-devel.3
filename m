Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667A3C36011
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Mar 2025 12:37:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1txPzw-0001YX-Ld; Wed, 26 Mar 2025 08:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1txPzv-0001YA-JH
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:36:43 -0400
Received: from mail-northeuropeazon11021129.outbound.protection.outlook.com
 ([52.101.65.129] helo=DB3PR0202CU003.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aleksandar.rakic@htecgroup.com>)
 id 1txPzt-0007ym-HJ
 for qemu-devel@nongnu.org; Wed, 26 Mar 2025 08:36:43 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oX4sfreHBHDYIuzLVTuKnPDxp4oPKKibddegcH7M/7lHLWVwRKIUblLStsDCka0DT8wy71GJ8v1EJbp3kdfFkHpK4YX0Hoe7Decoa6iEpDVEhmeAP7OCVCkV6iwHwd7p2gKQfL+St+QO0BQhbZpi6F6gQ2XyibJZ0BgFC2P7FZyHr6MbQfoosa+c4mtERWfC40YcygECClSwsIdrxzvZHHejsi2UfGZGeWKD0IN+c63ApkTuUx7Xd3Kc4HW9JxafIXJy7xEnv5QJHR1nxwsBGhoYRGSsp9Na97q2TN6iXMHBBb1MFujzEd67dQFCTLXS0kPrjEz+oUefOFFeBjKE6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=K0aU7R9HZec7h5c9+QOfkYt4zFw1aa0Zk8q2GGl8ybMj/YiqMFkpzX5xHe3RBKz6HV/OBv001UkfC68h9/u9n87UooGg+5q5zrzErPy1gGXkLYAMtPpu6qOCLP86oldDHfigWhHuhpvMWewON9eVLwcDV6fIQGfzysfrTU4a6d+/mspm7IswlGqrFTheC+2rOVaibq/Ie29jjk4qr5A+LNOQknKKUyhB5PsurcKIdjV6ZCY4cLYuU9UjIeVsA+JoK4SXxM1W/WbNlYaHsuCc+YW7HxRZwiJfi23c+y6DGFr16HGePFNQOxonFm4XV50q2FrBy1+A2DIfUOJjqLjKJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=htecgroup.com; dmarc=pass action=none
 header.from=htecgroup.com; dkim=pass header.d=htecgroup.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=htecgroup.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G2w8LWqlZkDcaH8qH9Uq6KlhEeTtunfzZNVMtuKi0VM=;
 b=S8Tr02MjeG9w9eXvme5GbeAz5iQ2sQbe5Z/uQzqcUVM9HZOQIhc/b7r3Pu4Zd5Zbst729Mo5ulIYRW94A93TXFz91nJnraLhOKJxZfQKdlPX8JbbKdgHcYXaq55+cB4puq4zyzgUR8XCM/glRvrL6gzDvjx+eNZ/pa0N5OkjSi0UEueZg5B7BGjRgsdDH05ROTP3xsvZPXSsBvvwVcbXKHuEmpKhLwu2kO7lgnFROly+t0po/nTAXkIwMEPCZEHSI2JtrD8GvkT2Sna+oUM0Pa2yAGz7XcN9y/6PF/ezGzH6Rf0cr0B0FGz0za/PZHJUrwRIVkre9uBl7bj9r4NzDA==
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com (2603:10a6:20b:2d4::13)
 by AS5PR09MB6746.eurprd09.prod.outlook.com (2603:10a6:20b:655::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Wed, 26 Mar
 2025 12:31:34 +0000
Received: from AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2]) by AM9PR09MB4851.eurprd09.prod.outlook.com
 ([fe80::2fed:370:dd45:13a2%5]) with mapi id 15.20.8534.043; Wed, 26 Mar 2025
 12:31:34 +0000
From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
CC: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>, "arikalo@gmail.com"
 <arikalo@gmail.com>, "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "philmd@linaro.org" <philmd@linaro.org>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
Subject: Re: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Topic: [PATCH v5 1/3] Add support for emulation of CRC32 instructions
Thread-Index: AQHbiHBMKhjxNs/1dk+vCUF69yvpRrNvpGeAgAlizQCADH3GgA==
Date: Wed, 26 Mar 2025 12:31:34 +0000
Message-ID: <20250326123059.1268756-1-aleksandar.rakic@htecgroup.com>
References: <20250318134542.585521-1-aleksandar.rakic@htecgroup.com>
In-Reply-To: <20250318134542.585521-1-aleksandar.rakic@htecgroup.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=htecgroup.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR09MB4851:EE_|AS5PR09MB6746:EE_
x-ms-office365-filtering-correlation-id: 93036b92-28c0-4655-ea8d-08dd6c622546
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?AIWXEd+8Y6HzmCQQePwwKA0uvlhUeGcm4RJaYe7254Z7XvAign9T/9kUEj?=
 =?iso-8859-1?Q?T+c1r7kH0sjeYx/2V0dQszpC2ow7gM3f6do96VYmq4LocyQugI+DqRr6Qp?=
 =?iso-8859-1?Q?G+l5v7L6c8F2EQWrVH962qgZEja74i5s2TrlWisFZifMfYLVQtLR1ZyvOB?=
 =?iso-8859-1?Q?nlFTmQh66eOZB6l68WOl3gTf3WdElXhp8KnIFuHDTfxfH7LZ8az/qNwvQP?=
 =?iso-8859-1?Q?Wc4VMPqrShfC6aIXi94bTE7qdkb5VNjAgNGd7tUXkIJmIg8NDMeAFK8tob?=
 =?iso-8859-1?Q?1Fj8CJXRzlbPBX75ppy4VC214UvKpYbvXafbkGj4lenmUJ2gftCt9Y7iVv?=
 =?iso-8859-1?Q?f/F2l6c+ZU47aZJhhPEmi1aXab7lX4Ue5Yo6h/J2E2AREzKPCJNpVZceUy?=
 =?iso-8859-1?Q?fl/vFr+ZG1V3s+WJkT2FSfy2GTGjjIKroi2FNxqjU9Henqfar1Q5VJ2A26?=
 =?iso-8859-1?Q?Nj7DUvNhe/vO71MOk9fYziNM3TMWGUZM8DGV40fpFuC7D3siP9FW6Ug9LV?=
 =?iso-8859-1?Q?XYmfuR8vYgL+zwOw0Wr3x8SFg0d0EUuM4Mw51hDioIotCxE7fG4M/BbXpK?=
 =?iso-8859-1?Q?uW1Cm6RiMyw8prVZLo2+Pz3bpKrE3vTKedehlF4x3EfiffM1qxz8egUtKu?=
 =?iso-8859-1?Q?qfLJYUS/n4I7dmIk7o+zUzHQT6m9dSBOd8ktwXVVc+9tVoO5kYfGpXY3HY?=
 =?iso-8859-1?Q?hALSOArCMqh2MQ9sBOKFJW3lcCbh4AckK3zcgunjphmpo9C7Jyd563F/LC?=
 =?iso-8859-1?Q?YNV4YV6dW0z+reAbqzDlKIyArla7A3aRRR4zu7T/d+3Kq/ndTfeT7IZfzj?=
 =?iso-8859-1?Q?X83R3iOFKCfPfoVHlC66952rMfZH+IEAX14sNNsx0eEYI1F4SnY+2Z35Hw?=
 =?iso-8859-1?Q?MlUDFDIqPeL5IMVuMnEBsai0ZHKacZSybA4cHIb8gvQqIWkuSBCTCT8RuU?=
 =?iso-8859-1?Q?2Yj2tiubc5ydd0/X5HIO7DZghEe91TJCErv3FNNYYmMxFhT+4lw5vwx8Jm?=
 =?iso-8859-1?Q?3H9iMCe37FltkLdLO/uHoRNyPb2KlmOA8+BcVOwF+iekAu4thicQTJkMsv?=
 =?iso-8859-1?Q?sjLh2osfMYCWxpxCN7fPambyHDUIImh0gNZmCGYr0/6HOytr4uERQEjGNC?=
 =?iso-8859-1?Q?UnsCRZjqbb7cy6R/f/MyCiDCB757CCyH7228k4I4dXt0N0HVlOun1akyjd?=
 =?iso-8859-1?Q?gT6/nK+kwoShl5ARDnU1us2JyaQe3wTCYh8zAv3EJXy7WA9wD5umt9KBun?=
 =?iso-8859-1?Q?g501YuMWAdV2FXes/aTI+EFB3/rL4mjgclhc6lt4NnEcjgKQE4h72FQG3e?=
 =?iso-8859-1?Q?xGKwlemDSTkGaukanuhrpE50NBJ95cEZuSIDNQt0ap3BRtuzKpLNL96xrT?=
 =?iso-8859-1?Q?HbVHhCtDpvwAXubUFMV2oV7sKiYu993XdDjx9MgW7op9saGpkRkPe1krpG?=
 =?iso-8859-1?Q?nDvg0ii8bRqzH9Rz3eCB7qIJKA/fu1j5WqSJxQpsmFgY7l58XVdavXRgia?=
 =?iso-8859-1?Q?NL4CoRGuEemPvHggZToT8P?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR09MB4851.eurprd09.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(38070700018); DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?KlLHHsioSIig9+O4Xh6ZJkkvo7HAyNLW4TRuDlZN5AErFJrWsORRxyzaGu?=
 =?iso-8859-1?Q?FOoTnfYBGX1pjy5Xm6Oa2Y/mh5839SdNmAMnZgIg2y2mRBJ8Lsk8pndmJW?=
 =?iso-8859-1?Q?REo25vDRRwmer1j29b4Dmz4PbvUoD0nxB9Gw4ZGqIXm6uRV7pp8wuBujTI?=
 =?iso-8859-1?Q?H90HBnLxYsjSZEikmXlE6cBLRSSovstPUa4EyHHa8RiAN1HO5b66Y/R9Ri?=
 =?iso-8859-1?Q?0YS2TpOEOhf9pmj+veLC/S7tbOKVaJAmypNZyPvQYKizRZBClFVTfDNvL9?=
 =?iso-8859-1?Q?KJ5gnLx/chgP/2ZEMxI6kIwZ5q65ZaCuCSX1xqEDr3I5Asu/Lif5yh0nQ7?=
 =?iso-8859-1?Q?lqkzGmoESjIAOD6BpF08uww5dlx/flp92+pXdXeIUJtxFd2Mljv4+v8hoU?=
 =?iso-8859-1?Q?9yO3pM4O5Skn0hJStehmW1m2RI9qCP7+3sruzf9fFSXv2JXXe2eWiqCmN4?=
 =?iso-8859-1?Q?S2IzOVkxyCXn+PkmHrc+isU9SkZyr09jH/YHu2Wd0qKBPtGphqq40M5uVX?=
 =?iso-8859-1?Q?s/ZsXDZ5QKdTyKTs7d62ieaxX0lcOjwVYtgcBBCgI3OGlmTI7PeNHFV6zL?=
 =?iso-8859-1?Q?1hl1TSm/n40sCmrUxjzKVFKbljZyIHvYi6IeQZF/sn2783E8YxxrtfU4JT?=
 =?iso-8859-1?Q?HNvgXtxxHebbcH9J89t3gL46m6PTrAF/5MKjaoeS5VQSube14Yj1nBvfrO?=
 =?iso-8859-1?Q?2hZRdK9ngmiKRFRYYHIDUXJrVuO65Yg45p1CcdG3XbhbXvoEiIN8mr4FhH?=
 =?iso-8859-1?Q?v7CphoUmSLsmabMLVskCxxEYahXiWcbkOLT0bLnC79RIQCJCKq7uoNsm2D?=
 =?iso-8859-1?Q?Y/yLvhMC0uFr32h9jq8nTPhfQNUM/lYx/5rsRTPqFHPqPgNU/sMjg4joY5?=
 =?iso-8859-1?Q?XqUW7KXKYckYklVJhjOkd4Cd7SN5kGz1X66Rxqb7pxoLPxBDS9ebACpSwk?=
 =?iso-8859-1?Q?xkG3edUjO3hrKA/mpQThtTIh1wyBlo4trF51JT5Gj8Wwf74BETrUndzBWf?=
 =?iso-8859-1?Q?wyIUpEeHih4D7gVuj3ODy9kFICm9PsgqoU4o100Z+uGVdNp6Xl2xuInQL5?=
 =?iso-8859-1?Q?9D9IVA2Ro+Tl/PqshZXft1A1oIZjw6roZlGpU8qzWKC7AS2wZXvbBxe8+/?=
 =?iso-8859-1?Q?TM4ZOOVUDVt+l0XUpMQn+X69TMMxLEPv/hfFaij0WlUCWmmg9L2ZmG0S88?=
 =?iso-8859-1?Q?PYjT7b82XMGemx7AnHKg3WlhF1TPfDTOQmyZsrRvY7kiMs0pgnAME/UAy7?=
 =?iso-8859-1?Q?RtL4fmsOrc3cYN7rkN2PZ/p9izTr9pjroD7XFSqawZzAApv8POmV1OnRRP?=
 =?iso-8859-1?Q?IFTlwsc2P4Sha9ndd39HCsNg2/FUDin+f0vz1+A8XfypNNiY0B9A7OxWVf?=
 =?iso-8859-1?Q?y62h09tXK1YD5kBhzrhyvVBfvN/xsi/5/TZbXaci3+YHLl9p4wDRLYg7Ar?=
 =?iso-8859-1?Q?v42+hhHKgFr2X78NH4tZcRfiE/ZMeWPFaXBPS8Fia/TDUSvbI+9QAoeoeD?=
 =?iso-8859-1?Q?8PFBh/2tYG4Fj4WSHuXZlLLJHp9V1efQOYVbbbJX1HIKJr945hk4g6cgx+?=
 =?iso-8859-1?Q?l3gJE/OMmEOFkiXc87x6XYG8scu7xwNIWjBsDlfYjN6ySuGuluq9cFyJYw?=
 =?iso-8859-1?Q?G2ByUehSR5DC5NrHNAVliJiYXxFTGZyg2a8GkgKT/Aiss6Bp/JS8rveLdx?=
 =?iso-8859-1?Q?faon7CJqzqVMXvy1WR8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: htecgroup.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR09MB4851.eurprd09.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93036b92-28c0-4655-ea8d-08dd6c622546
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2025 12:31:34.3895 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 9f85665b-7efd-4776-9dfe-b6bfda2565ee
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /vdMRuc7F5xi2DCb0mWyu0jMuktynZ3PczWmBPESylh2SlUribnuYaPfO78lGTh4kYdkiRimEneUTX8KXAr6qiF85xJrkDJAkUNIrSnVCso=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS5PR09MB6746
Received-SPF: pass client-ip=52.101.65.129;
 envelope-from=aleksandar.rakic@htecgroup.com;
 helo=DB3PR0202CU003.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

Could you please let us know if you have any comments
on the latest version of this patch?

Kind regards,
Aleksandar Rakic=

