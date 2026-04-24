Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5353FB44C8
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Apr 2026 08:07:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wGBXc-00050B-3h; Fri, 24 Apr 2026 04:05:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXZ-0004u6-1v; Fri, 24 Apr 2026 04:05:33 -0400
Received: from mail-japaneastazlp170130007.outbound.protection.outlook.com
 ([2a01:111:f403:c405::7] helo=TYDPR03CU002.outbound.protection.outlook.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jamin_lin@aspeedtech.com>)
 id 1wGBXW-0001GV-8w; Fri, 24 Apr 2026 04:05:32 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJTYBUosmU+kvwyC3g6uExVIEy4mST7TCovrC0/MGy2HFyY7swwONxmqGVaLCOoGHRUNHwxMD/G95yhUCvuO3FWyQbPTZOfNPGYcyyomzcqDIuo5Nc17+uYHky4fxNFFjkYxNLZnctVtWzLVagVT5vVshKIUiUCYAtT3jeZox2nNZLtFN5o9uA0/gr97rVbUVrwal2m14gQgWxXr+wANwMt190D5WJPSkmkUOTak6nrHjH027Yn72wgOzk9TecAkusWaI0XyEl77mffDLm+/djajz9gzAJGY4Q05XOAKkDBGbSC9trMpt/VzapRYJGS4m4qdvnKT1ZeX+O+DFsBuLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t876nfq1PurFy1REImxgXmZt9Yx/BFkWkH/U1x38zE=;
 b=eBSxyBYt615sKUKRAMSZ2BeV43BS0tq4STcJSgo0y7Wdgs3DPg1Gpe9VB0iGYG4/ghhTPcOGa7lPcpw3OlRMII74ScaMf8tkewGuU/WT1m8y7jFfCQsM3sF/eHcJCvUt+2pKd6cJxIf0G+2xKyC986p+1W5touusLuhAoreDVR63+LXkc7SshY1W3h2OqNZCIdpLNXgYTkxi9rxgTZHrIjYZtxaL1V/F1PW9H9p9UPbeejSs1/2+iaWloBfx5cz1st3J2BpphQ1IZDDLHHDvc5iOi9BGDbW43HPX74wgl4sRBOxbEUPI4mcYP4Dv6K0G3Ic6RP85fq6V2r1nDq0S6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t876nfq1PurFy1REImxgXmZt9Yx/BFkWkH/U1x38zE=;
 b=VoKhM+Q4tIUOwVva5a4qXVefqgwNkK5n7WUUp4qr/m/9WQ2qoztNhnrAP5xPlns2sEbYlPKron7JO0varJZKpUJNYSOzdmucxgxlufJjIqWQsv5jegsMB+Z2V+kwvKMQ0FivtI0otM564tMojTegMU3FAQGfv4bBGLOwgEYy/2QBw0rJr+B1sMHyL5JggF4oEjg1PBkCXzvtzxXWUuYetgqhWLJdItcfEJOIl6h+WnZyQeZBxMVr7TCv0h9CBUk8od4ub9vJWfzaOMENs3YHcwG+7QBPlHuRRNxn+ioBpzHf4eDGgjaNwk5hjs+bIRdZPtuRLl+fyd5vjSCjJqyLxw==
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com (2603:1096:405:383::19)
 by SEZPR06MB5856.apcprd06.prod.outlook.com (2603:1096:101:9e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.18; Fri, 24 Apr
 2026 08:05:20 +0000
Received: from TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3]) by TYPPR06MB8206.apcprd06.prod.outlook.com
 ([fe80::e659:1ead:77cb:f6d3%3]) with mapi id 15.20.9846.021; Fri, 24 Apr 2026
 08:05:20 +0000
From: Jamin Lin <jamin_lin@aspeedtech.com>
To: "peterx@redhat.com" <peterx@redhat.com>, "philmd@linaro.org"
 <philmd@linaro.org>, =?iso-8859-1?Q?C=E9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Kane Chen
 <kane_chen@aspeedtech.com>, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>, Paolo
 Bonzini <pbonzini@redhat.com>, Richard Henderson
 <richard.henderson@linaro.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <laurent@vivier.eu>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Halil Pasic
 <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, "open list:ASPEED BMCs"
 <qemu-arm@nongnu.org>, "open list:All patches CC here"
 <qemu-devel@nongnu.org>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>,
 "open list:S390 Virtio-ccw" <qemu-s390x@nongnu.org>
CC: Jamin Lin <jamin_lin@aspeedtech.com>, Troy Lee <troy_lee@aspeedtech.com>, 
 "farosas@suse.de" <farosas@suse.de>, "flwu@google.com" <flwu@google.com>, 
 "nabihestefan@google.com" <nabihestefan@google.com>
Subject: [PATCH v5 08/18] hw/core: Add 11.0 machine compatibility properties
Thread-Topic: [PATCH v5 08/18] hw/core: Add 11.0 machine compatibility
 properties
Thread-Index: AQHc08EYz77OLqMUiE6xORGmT3HWyA==
Date: Fri, 24 Apr 2026 08:05:20 +0000
Message-ID: <20260424080508.53992-9-jamin_lin@aspeedtech.com>
References: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
In-Reply-To: <20260424080508.53992-1-jamin_lin@aspeedtech.com>
Accept-Language: zh-TW, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TYPPR06MB8206:EE_|SEZPR06MB5856:EE_
x-ms-office365-filtering-correlation-id: f08ba83c-cb7a-475f-f34b-08dea1d83aac
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|38070700021|921020|18002099003|22082099003|56012099003;
x-microsoft-antispam-message-info: Iekyu2f5xx/mEfTM+/oitNfAJY3QXq1IXbbZFJGVxk7EehScF79Pt1G1pods+qp5r2fNxnBfEArkDtdsj9Q46HjBAUAFp7KH7zKY68gmC+gY3E7zEvaQh91a1dQpFKCXu7ESE0JXVW0O2gyADtuf2wNEF2KbRfOfySChbkFVrS3PcrJ34+1Z5KkeZEcRElo72F+efLuZ0Fy9uadz9DOHHYImtxyx141kKhikH2vpMs4l32x7F1GqFmkRtMu3CnFEU2HNXu7NgSts19pZh8p8xqfgIZyYfbeX8reKGRLdT2Ibq5xLUdMs73twgMIsgAEPpzd+gHt8WlyUgpHvulYnKHNhoHxAutixIUHBp3siWmE4tKFFITrnNQWF1jRaaX1FYqB3551Q2QL3oyzycBPkYYM2EurY91H76Q+Y35LYv5qYD3Uj5Qksg90p3DyNpcgjVGthRAjOj0QMnGUQ8EdRP6S+fCr9Th758abQaC2v2JvDkIwAYGnZ/JnthajaRIGxBz0k61aM8YMMDXXlR8XU81+3p/+TtpZ28x2tX/PI9pkBoiIlr9KrhgcC5aVgt++Op66P365+GM0wScsbE5dxcB+HquuGHwcKgAgSdX4H9iKl8BzOauP9Z9IC2CcMw8P1v8fYa4Oee4EYIXvYbi7zWto/+oTahorp9YfyLn7SYs+pclrc4aAbdY6GFN348BTwfCyLpX+1DAiX6zxBw+T3pkIdIxwvuW6vG759mrAeLFqU/8VF7ZOs6dnCZjr1fuvIecuEBmBXKnpIel2R7LxmNjRhZ7gSUOAqmeeQshwjzf+0gTA9eFBKTACMl1hmcpZH
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:TYPPR06MB8206.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700021)(921020)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O/loUQE22SkhmZp7A/6rDQe53lEdv0bdUMCSv74YiQPf9z4iRqPS3+24EA?=
 =?iso-8859-1?Q?iLouicfmzpIwhDxOKUKWkyBMiyMO7Sz9gYYSWsLV81MR46Vx28eOMmTeNC?=
 =?iso-8859-1?Q?11ABzhwsaoCpRepgacB7jaChJVpNkyK9uCiqGrHPBxb67WqmiyEVm0f90M?=
 =?iso-8859-1?Q?76xRVFtZS8vzlK1Pg12XCQCxgIlHGoPO1+T6jnNkdsGuxNelpqTEq/g107?=
 =?iso-8859-1?Q?hr/upUTdXq27L775/6zc4kn5b9dbz/oP5480Lec6aN848/yBdCQ7Mpaq0y?=
 =?iso-8859-1?Q?xLmERkIap7PCAmIKp/yA5+dV+VEgCta41mDwfWfmfDxem5ODtqEg6YhPDr?=
 =?iso-8859-1?Q?6u0vg4uV7PUArm8V/iTqddfktEhS7gcnqLEpbje9e7p5Eg52ckXRfS7tTu?=
 =?iso-8859-1?Q?G5jcq/AKlvwb/PV6yduFs2uiceT6QFom1xakfVLkAE+L/fLqasH4sgiL7D?=
 =?iso-8859-1?Q?cpON/P0RKbQOwogdijkwpWTrQl1RVZGRQiQ04SOIW39nc9Bm+r9769tuYZ?=
 =?iso-8859-1?Q?r4+nbX+wqg4131hvoP3kecudkASdFWBdXBqCdSnzAp6EAj8BMvkyA2eX3D?=
 =?iso-8859-1?Q?qWS6JfSHXX1YvIf3nGNDqtB/dELxwWhfI8M9acfPEQp4FDKcKjX+jfN3Jr?=
 =?iso-8859-1?Q?QW4qx3xnwG2J36g70UAwxiDJkDd5SRh6f3sbv6xLQt7Lyr5GwBTlsY9epD?=
 =?iso-8859-1?Q?NhBnWRaw4L9n3LNVN4ZlORozMuqwLvu444onTcYNBxu/g130pUEUvAzU7d?=
 =?iso-8859-1?Q?cnEhbrgKVpGGI3ph6c46BPpRStr04fB73nRx2oPt3nEmtpkxd4ojYVWRMQ?=
 =?iso-8859-1?Q?B2Sb+V2WKeOqOV4lH4rSgKBaQkWhzVJSlg39pi4cINs29CCfZOJROk+knr?=
 =?iso-8859-1?Q?Bj4eDfsMmZasuBIxWDMlYk2Od/1O8cIhrO7NdhGu4k2OHocLYuH46UK3/5?=
 =?iso-8859-1?Q?Glm8pB5yO5PAGWSD69/E4ZuglT1iz7ivLaeqRqOPudeDP90fktbyb6wyb/?=
 =?iso-8859-1?Q?A+5wLBBrdLNNf3S0NpLxitHnXXCQ6m0TOv8ZmOcpkKQ0pwWELdXIROYMgw?=
 =?iso-8859-1?Q?fVanTSk1L2QsztzJU2KeBOey51iBjK9lksmGkYOf7b0VSjt2CnW8+bR5S7?=
 =?iso-8859-1?Q?/L9IfuItuy4vJVO4vXm7xlTeJ5Z9WvJPd2Jj5Rj7VcTlrPIAmYv2EkFGE2?=
 =?iso-8859-1?Q?N15f+9S7fNfH/+pI+YjbYylORrqSlnJR393Vm5TAQ9pUqq2WdW4Maxfz90?=
 =?iso-8859-1?Q?Z/OvaWf8v8R7exSkqWGav4Fy2Hqba4W+6ITVmGELlzm9v2aUXXjwANf/wS?=
 =?iso-8859-1?Q?mDONVSyL+TdgNWy3Ok2L/eezZtA7yDntZaiLXpm7N3pI+sM09zHTv3lcYi?=
 =?iso-8859-1?Q?AbEmFU1vd6YRfguPDdCElE0Bh0ROBeqo1wQrINhBhtW25vLgVY4FrlNtr9?=
 =?iso-8859-1?Q?wLMy4PQ2DU9Q+mIpIlT4eDmvzuQTFSAoNX4jB8QV4fqQD7xzOow0ThxHhY?=
 =?iso-8859-1?Q?woCv/QRVpcqzU7WnnUCc4n2IZrqpDvC1Id1P+O6rUzjIA+qeCu/5V/Mdog?=
 =?iso-8859-1?Q?7x0Kyg750vcO/CADvyCPL0w771woVsMAzigujfIc7/7aR/RgMJErhD8Tqm?=
 =?iso-8859-1?Q?SA253DB1T4jjFLw3LnMNhsMgAwRPCptlhryRMhqQSOsrClyba+LQXH+lQ3?=
 =?iso-8859-1?Q?Z+tFdwRyn5Klnmp7fS3CxhlX99yj+iqmUQt7DG3Wz9BUok3RmBpEA7TV3f?=
 =?iso-8859-1?Q?usunHRKjIt88T/rLQwEqiVPCVxPr5IJXt+6Z/o1iiRl6UmS0/KVQXBXoBJ?=
 =?iso-8859-1?Q?d6z948nB6A=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: FirCX0mxlDbP5hhcCqn+Lvwfr1tOvQRonqRpnm2DtywHxVjDL9VA0mg936ZvpPhj06wlapXYAJiEKSxFWNcQ3IRKAyPwZjaraLC4470q+mXbi04a5HIR4mcHujxUlQriQ3XGL5C0csd4X6GQzB1OTxNsQCvQ9y17o8hQxKWDpEBwfi5fwA9E6zgGIaV1ZMF7m3GTq3LNCGaRbZjjU/I1I1GHZG/3NxRhA7qmqkFVGPpqV7U2DFYj1B2WC8hX303CfnoAMVu5q5S+II0BsrKnVYYG0fCa6fS271QGB/fzUBZUTGnXMmSiXOe7fQeFQ3NqRO/T292X5H69lPXDUB6afQ==
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYPPR06MB8206.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f08ba83c-cb7a-475f-f34b-08dea1d83aac
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Apr 2026 08:05:20.2459 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pExG1yh/x0i/ZbbJae58LRiwsCPivtpW9MeRJzb4zPoN4alX5aOqR2GmgtsrbouKhrs6GKe+B0IVImwj/7CPBzJhW4kWb7D9UD1vFq2EKeM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB5856
Received-SPF: pass client-ip=2a01:111:f403:c405::7;
 envelope-from=jamin_lin@aspeedtech.com;
 helo=TYDPR03CU002.outbound.protection.outlook.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Introduce hw_compat_11_0 and pc_compat_11_0 compatibility property arrays,=
=0A=
and wire them into the 11.0 machine types.=0A=
=0A=
Update all machine types so that version 11.0 inherits from 11.1 and applie=
s=0A=
the 11.0 compatibility properties. This follows the standard pattern where=
=0A=
older machine types retain legacy behavior through compat properties, while=
=0A=
newer machine types provide updated defaults.=0A=
=0A=
This change allows devices to maintain migration and behavior compatibility=
=0A=
for the 11.0 machine type, while enabling new behavior to be introduced in=
=0A=
later machine versions.=0A=
=0A=
Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>=0A=
---=0A=
 include/hw/core/boards.h   |  3 +++=0A=
 include/hw/i386/pc.h       |  3 +++=0A=
 hw/arm/virt.c              |  8 ++++++++=0A=
 hw/core/machine.c          |  3 +++=0A=
 hw/i386/pc.c               |  3 +++=0A=
 hw/i386/pc_piix.c          | 11 ++++++++++-=0A=
 hw/i386/pc_q35.c           | 11 ++++++++++-=0A=
 hw/m68k/virt.c             |  7 +++++++=0A=
 hw/ppc/spapr.c             | 13 ++++++++++++-=0A=
 hw/s390x/s390-virtio-ccw.c | 11 +++++++++++=0A=
 10 files changed, 70 insertions(+), 3 deletions(-)=0A=
=0A=
diff --git a/include/hw/core/boards.h b/include/hw/core/boards.h=0A=
index b8dad0a107..db83fe9292 100644=0A=
--- a/include/hw/core/boards.h=0A=
+++ b/include/hw/core/boards.h=0A=
@@ -798,6 +798,9 @@ struct MachineState {=0A=
         } \=0A=
     } while (0)=0A=
 =0A=
+extern GlobalProperty hw_compat_11_0[];=0A=
+extern const size_t hw_compat_11_0_len;=0A=
+=0A=
 extern GlobalProperty hw_compat_10_2[];=0A=
 extern const size_t hw_compat_10_2_len;=0A=
 =0A=
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h=0A=
index 22325324d0..85a74363b5 100644=0A=
--- a/include/hw/i386/pc.h=0A=
+++ b/include/hw/i386/pc.h=0A=
@@ -208,6 +208,9 @@ void pc_system_parse_ovmf_flash(uint8_t *flash_ptr, siz=
e_t flash_size);=0A=
 /* sgx.c */=0A=
 void pc_machine_init_sgx_epc(PCMachineState *pcms);=0A=
 =0A=
+extern GlobalProperty pc_compat_11_0[];=0A=
+extern const size_t pc_compat_11_0_len;=0A=
+=0A=
 extern GlobalProperty pc_compat_10_2[];=0A=
 extern const size_t pc_compat_10_2_len;=0A=
 =0A=
diff --git a/hw/arm/virt.c b/hw/arm/virt.c=0A=
index ec0d8475ca..4855105f18 100644=0A=
--- a/hw/arm/virt.c=0A=
+++ b/hw/arm/virt.c=0A=
@@ -3719,8 +3719,16 @@ static void machvirt_machine_init(void)=0A=
 }=0A=
 type_init(machvirt_machine_init);=0A=
 =0A=
+static void virt_machine_11_1_options(MachineClass *mc)=0A=
+{=0A=
+=0A=
+}=0A=
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)=0A=
+=0A=
 static void virt_machine_11_0_options(MachineClass *mc)=0A=
 {=0A=
+     virt_machine_11_1_options(mc);=0A=
+     compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len=
);=0A=
 }=0A=
 DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)=0A=
 =0A=
diff --git a/hw/core/machine.c b/hw/core/machine.c=0A=
index 0aa77a57e9..1abc8ae737 100644=0A=
--- a/hw/core/machine.c=0A=
+++ b/hw/core/machine.c=0A=
@@ -38,6 +38,9 @@=0A=
 #include "hw/acpi/generic_event_device.h"=0A=
 #include "qemu/audio.h"=0A=
 =0A=
+GlobalProperty hw_compat_11_0[] =3D {};=0A=
+const size_t hw_compat_11_0_len =3D G_N_ELEMENTS(hw_compat_11_0);=0A=
+=0A=
 GlobalProperty hw_compat_10_2[] =3D {=0A=
     { "scsi-block", "migrate-pr", "off" },=0A=
     { "isa-cirrus-vga", "global-vmstate", "true" },=0A=
diff --git a/hw/i386/pc.c b/hw/i386/pc.c=0A=
index 4b53b5be4a..2ecad3c503 100644=0A=
--- a/hw/i386/pc.c=0A=
+++ b/hw/i386/pc.c=0A=
@@ -73,6 +73,9 @@=0A=
 #include "hw/xen/xen-bus.h"=0A=
 #endif=0A=
 =0A=
+GlobalProperty pc_compat_11_0[] =3D {};=0A=
+const size_t pc_compat_11_0_len =3D G_N_ELEMENTS(pc_compat_11_0);=0A=
+=0A=
 GlobalProperty pc_compat_10_2[] =3D {};=0A=
 const size_t pc_compat_10_2_len =3D G_N_ELEMENTS(pc_compat_10_2);=0A=
 =0A=
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c=0A=
index 4d71e0d51a..19e9641246 100644=0A=
--- a/hw/i386/pc_piix.c=0A=
+++ b/hw/i386/pc_piix.c=0A=
@@ -428,11 +428,20 @@ static void pc_i440fx_machine_options(MachineClass *m=
)=0A=
                      pc_piix_compat_defaults, pc_piix_compat_defaults_len)=
;=0A=
 }=0A=
 =0A=
-static void pc_i440fx_machine_11_0_options(MachineClass *m)=0A=
+static void pc_i440fx_machine_11_1_options(MachineClass *m)=0A=
 {=0A=
     pc_i440fx_machine_options(m);=0A=
 }=0A=
 =0A=
+DEFINE_I440FX_MACHINE_AS_LATEST(11, 1);=0A=
+=0A=
+static void pc_i440fx_machine_11_0_options(MachineClass *m)=0A=
+{=0A=
+    pc_i440fx_machine_11_1_options(m);=0A=
+    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);=
=0A=
+    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);=
=0A=
+}=0A=
+=0A=
 DEFINE_I440FX_MACHINE_AS_LATEST(11, 0);=0A=
 =0A=
 static void pc_i440fx_machine_10_2_options(MachineClass *m)=0A=
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c=0A=
index cb23322f5a..72dd3324df 100644=0A=
--- a/hw/i386/pc_q35.c=0A=
+++ b/hw/i386/pc_q35.c=0A=
@@ -364,11 +364,20 @@ static void pc_q35_machine_options(MachineClass *m)=
=0A=
                      pc_q35_compat_defaults, pc_q35_compat_defaults_len);=
=0A=
 }=0A=
 =0A=
-static void pc_q35_machine_11_0_options(MachineClass *m)=0A=
+static void pc_q35_machine_11_1_options(MachineClass *m)=0A=
 {=0A=
     pc_q35_machine_options(m);=0A=
 }=0A=
 =0A=
+DEFINE_Q35_MACHINE_AS_LATEST(11, 1);=0A=
+=0A=
+static void pc_q35_machine_11_0_options(MachineClass *m)=0A=
+{=0A=
+    pc_q35_machine_11_1_options(m);=0A=
+    compat_props_add(m->compat_props, hw_compat_11_0, hw_compat_11_0_len);=
=0A=
+    compat_props_add(m->compat_props, pc_compat_11_0, pc_compat_11_0_len);=
=0A=
+}=0A=
+=0A=
 DEFINE_Q35_MACHINE_AS_LATEST(11, 0);=0A=
 =0A=
 static void pc_q35_machine_10_2_options(MachineClass *m)=0A=
diff --git a/hw/m68k/virt.c b/hw/m68k/virt.c=0A=
index ffe6e23415..b056ef603c 100644=0A=
--- a/hw/m68k/virt.c=0A=
+++ b/hw/m68k/virt.c=0A=
@@ -367,8 +367,15 @@ type_init(virt_machine_register_types)=0A=
 #define DEFINE_VIRT_MACHINE(major, minor) \=0A=
     DEFINE_VIRT_MACHINE_IMPL(false, major, minor)=0A=
 =0A=
+static void virt_machine_11_1_options(MachineClass *mc)=0A=
+{=0A=
+}=0A=
+DEFINE_VIRT_MACHINE_AS_LATEST(11, 1)=0A=
+=0A=
 static void virt_machine_11_0_options(MachineClass *mc)=0A=
 {=0A=
+    virt_machine_11_1_options(mc);=0A=
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len)=
;=0A=
 }=0A=
 DEFINE_VIRT_MACHINE_AS_LATEST(11, 0)=0A=
 =0A=
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c=0A=
index 0ab39dfea6..5876f97979 100644=0A=
--- a/hw/ppc/spapr.c=0A=
+++ b/hw/ppc/spapr.c=0A=
@@ -4760,12 +4760,23 @@ static void spapr_machine_latest_class_options(Mach=
ineClass *mc)=0A=
 #define DEFINE_SPAPR_MACHINE(major, minor) \=0A=
     DEFINE_SPAPR_MACHINE_IMPL(false, major, minor)=0A=
 =0A=
+/*=0A=
+ * pseries-11.1=0A=
+ */=0A=
+static void spapr_machine_11_1_class_options(MachineClass *mc)=0A=
+{=0A=
+    /* Defaults for the latest behaviour inherited from the base class */=
=0A=
+}=0A=
+=0A=
+DEFINE_SPAPR_MACHINE_AS_LATEST(11, 1);=0A=
+=0A=
 /*=0A=
  * pseries-11.0=0A=
  */=0A=
 static void spapr_machine_11_0_class_options(MachineClass *mc)=0A=
 {=0A=
-    /* Defaults for the latest behaviour inherited from the base class */=
=0A=
+    spapr_machine_11_1_class_options(mc);=0A=
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len)=
;=0A=
 }=0A=
 =0A=
 DEFINE_SPAPR_MACHINE_AS_LATEST(11, 0);=0A=
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c=0A=
index 3ef009463d..f5b6051a67 100644=0A=
--- a/hw/s390x/s390-virtio-ccw.c=0A=
+++ b/hw/s390x/s390-virtio-ccw.c=0A=
@@ -906,13 +906,24 @@ static const TypeInfo ccw_machine_info =3D {=0A=
 #define DEFINE_CCW_MACHINE(major, minor) \=0A=
     DEFINE_CCW_MACHINE_IMPL(false, major, minor)=0A=
 =0A=
+static void ccw_machine_11_1_instance_options(MachineState *machine)=0A=
+{=0A=
+}=0A=
+=0A=
+static void ccw_machine_11_1_class_options(MachineClass *mc)=0A=
+{=0A=
+}=0A=
+DEFINE_CCW_MACHINE_AS_LATEST(11, 1);=0A=
 =0A=
 static void ccw_machine_11_0_instance_options(MachineState *machine)=0A=
 {=0A=
+    ccw_machine_11_1_instance_options(machine);=0A=
 }=0A=
 =0A=
 static void ccw_machine_11_0_class_options(MachineClass *mc)=0A=
 {=0A=
+    ccw_machine_11_1_class_options(mc);=0A=
+    compat_props_add(mc->compat_props, hw_compat_11_0, hw_compat_11_0_len)=
;=0A=
 }=0A=
 DEFINE_CCW_MACHINE_AS_LATEST(11, 0);=0A=
 =0A=
-- =0A=
2.43.0=0A=

