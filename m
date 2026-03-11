Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D1A0112584E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 16:16:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0ME5-0006Pd-Os; Wed, 11 Mar 2026 12:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1w0MDs-0005w4-0M; Wed, 11 Mar 2026 12:15:53 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1w0MDm-0000TI-3P; Wed, 11 Mar 2026 12:15:44 -0400
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
 by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BDMbgW314342; Wed, 11 Mar 2026 16:15:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
 :content-id:content-transfer-encoding:content-type:date:from
 :in-reply-to:message-id:mime-version:references:subject:to; s=
 corp-2025-04-25; bh=Kia2NSxbeSioobFgO83vKbZX3QElXezb6VIhU3M+zp8=; b=
 ge07NcSoyL1rHKO8WpKbgRnaXx+1/iOly7s2ngBgfiu0O3XMEErg+piaXhrANIOn
 zuTKZ6OweWZLZObKauJMDIB+1EOvyk3w0MJOvzIcfYJgndb9VnGuwBlSMbAXcI84
 ry+4mV66lNpBh4lF0oL2gXWbc3TsMdwRW9MDfItV9YO2j8aNwQZricbjoYbfJg/P
 VKAMKmPuUoRnl+nKLtuabJQHG8Mdskwz9TdivLBx/ZbfXBwsADhM8OMxK37U+yck
 yf5Ji9QLdHmGT16BaBxwKSBSgoB/Cp4HX9mwPovw5Ao2jxkqV9VCTxbBnS9/tigV
 nsdcFllwBAKXva7ZejUk4A==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com
 (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
 by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cu4fartcx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 16:15:36 +0000 (GMT)
Received: from pps.filterd
 (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2)
 with ESMTP id 62BFvMLX012954; Wed, 11 Mar 2026 16:15:36 GMT
Received: from byapr05cu005.outbound.protection.outlook.com
 (mail-westusazon11010026.outbound.protection.outlook.com [52.101.85.26])
 by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id
 4crafga6uj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 16:15:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W6J/rBQG3GWv0M2I3HngA/MFD7IRkThDtDn1oGn+ghlkzx+eK/cRY5bJwH7a/SUtXXzYp69DHgKMxbZMSoXKzMbdGm5NEs1PVF9KXcNI49ZeToOH3MGXRFZb/EbOyHfcZZc/V6hty08toLL/8r/JMeXIu3NPsLO1eSAyjwgyk51EtRbquKJ0qDYByUBA5ZtW+dc0Z7Ogxs4jwWyxqYSKHypXxp4o5tlR/QL1DniJpRFo7Q0uy+mnimlol6m2zl9bcZYIAR1md0ldJ120mp5SsElw5A3f23z+Aa/i/sNRh1CdCDJcFljX1VGhrdPqLsjFaMiC/A+ZhluRP63fFMT5Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kia2NSxbeSioobFgO83vKbZX3QElXezb6VIhU3M+zp8=;
 b=oKtHxgq9IBR0ID4ihnCvVGnaVpYfgAHDjC1C7+YL4wCxBCEZKbJHQFBUvajgahRBr1KvtKI4cTZFDG5mQTISFABWYKdun5LKUGFlyXE89afSwlT7ugmFRBtMtptMFw1OI5SpCq/1zVPecBjocSBaNbQsYUN2i2lUAKd8yUTxkyl73iRLxWjVhNqVab3IT4MMmVguf6NSy3LVVpXeBze7Di0Co6zH/WNpurASNp/CrJ9eqjT3Gn11o9JeIf86Rp7n92sb6eyo1Ih9FY5jCMKdOOIxduacITwMZYH72bTpiiiai2Z9B7Q2kiI3P6mZOMqmo5wyUO/09EW/Ro1r6Hc8iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kia2NSxbeSioobFgO83vKbZX3QElXezb6VIhU3M+zp8=;
 b=US1j75gdBfu5thO4GQQzLHWmGMrIPfszaFUR6I8aqVwVAGZ4urOGXp+l+eDnErlSzIcXo/80TK9JS2fmgPlATI17ysdtkZkn73VB7ZelUbEsnmSdAFSDdzhGpDIxTmGo7I0oc8rnf5kJV3w84mSxTqp7VSVZ82NO/qWnXIGJsjc=
Received: from IA4PR10MB8301.namprd10.prod.outlook.com (2603:10b6:208:55e::6)
 by CO1PR10MB4594.namprd10.prod.outlook.com (2603:10b6:303:9a::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.11; Wed, 11 Mar
 2026 16:15:29 +0000
Received: from IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0]) by IA4PR10MB8301.namprd10.prod.outlook.com
 ([fe80::de06:e5db:6e3c:f8e0%6]) with mapi id 15.20.9700.010; Wed, 11 Mar 2026
 16:15:25 +0000
From: Jag Raman <jag.raman@oracle.com>
To: =?utf-8?B?Q8OpZHJpYyBMZSBHb2F0ZXI=?= <clg@redhat.com>
CC: Trieu Huynh <vikingtc4@gmail.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>, Maciej Szmigiero <maciej.szmigiero@oracle.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Tony Krowiak <akrowiak@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "qemu-s390x@nongnu.org" <qemu-s390x@nongnu.org>,
 John Levon <john.levon@nutanix.com>
Subject: Re: Deprecate Multi-process QEMU (Re: [PATCH 3/4]
 util/event_notifier: fix error handling for event_notifier_init callers)
Thread-Topic: Deprecate Multi-process QEMU (Re: [PATCH 3/4]
 util/event_notifier: fix error handling for event_notifier_init callers)
Thread-Index: AQHcsXFzSkzgAjYuF0e15I4zHN4wTbWpgZqA
Date: Wed, 11 Mar 2026 16:15:25 +0000
Message-ID: <EDF0ABCB-C0BB-4716-80FE-64245FF3280E@oracle.com>
References: <20260310182801.196443-1-viking4@gmail.com>
 <20260310182801.196443-4-viking4@gmail.com>
 <E1A0FC83-8A41-4ACF-A786-CDBCBF314F68@oracle.com>
 <99f0a899-a19c-4534-a0bb-042d7c530f38@redhat.com>
In-Reply-To: <99f0a899-a19c-4534-a0bb-042d7c530f38@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3864.300.41.1.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA4PR10MB8301:EE_|CO1PR10MB4594:EE_
x-ms-office365-filtering-correlation-id: 7f280ae2-2983-4a41-daaa-08de7f89679e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|7416014|38070700021|22082099003|56012099003|18002099003;
x-microsoft-antispam-message-info: SQ6tFSqEzeSsdhYQBI8yxpzfwTgpjW10la5xxoixMVK8QMi8PvwdL/qDV9iEDQoT+Tma0yXEjzXRuxFWHFe2BV/LYaEylcnwNMZQQkgnrVj05Of0PSB4OJqalSQQCONSpoGw9Mnd1uoV/hPYHM2W1m3enJpNNWGD6jSG2PEuQE9k8uz2RzciGSnGrqCXzHM029ZkFu3KWIDraxDMmGq2HDf+UiVCw1yClYq6H1lMskrb0ojCFdKV0mjkGaA4MPBJczfOZAc72Ae4Zm7bJyWNw1+al6Wq2JYOQELJ4nn7T9kiSNzmRIzkPL+w1LyEmpnOp22llVAt2M8n4WVhZILuJZ0/eje8wvaca3t+EhQjvrfCQ94sJWOfBq0wa6pMOd+/ZDI2LVO5lC9iT0mEpEhdRQwftpJX2C19MtjLgOViQOEKqYbEizgBhFz3TGEvheRn5E/wjLhQuU+8pvEqQwvRaTaIVd0GvnWrNAZJHm7zU0D4/hH2Nm8fQz7OmVhfgVbJ1FkbgkbknGNKoaRXf44cKw5xP4OkFCasDTB4DZ1vXekHSIC/laYnCOycHCIFJ6tibzmiqNamUSpTXpTxj2oMPOK/Wd1/N6qD30rfpiWAmsNDZpZDuj86scohrdCq7w7CqzSWC1YTe7HIuu8i3cGNq5z4xA1oCeqrEKyV7zMgLECcNivbnQDJYWDJdaIVqS3A1ad+hcgieKkvN58Lj3JahSNDk1sYDYWL2XFM0U5cz6ChMoVY0QowKboW9bH238u9/4X+9ebEpmDwmL5Q+KBM+bPi/hTjLTez/hJkY8BVkXY=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA4PR10MB8301.namprd10.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700021)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDlLTWlHZTY1dS9wSEV1UURrQzRZSlowWUZRbzlWcjdFRno3d3hIYXQzdGFa?=
 =?utf-8?B?R1FwS0w0blJKbzZTTzdSc1VSRVFWbUxaTzBrYS9kOFRMNEVhMmNYNHVjSlUy?=
 =?utf-8?B?L05VM1NzM20vbW5sRFU4dEd0M1hqNkhYQWZGS2laL0QyRzZlM1FhQjNHQ3lO?=
 =?utf-8?B?aFNmMHRYRnRyUXR5U3JDbG9JZ2JHVnBkYUIrc3ZlNU1FdTRlQ0h3M1lIOWto?=
 =?utf-8?B?d04wNEtXdFB5STJudUQ1M3g3Wm9hbE8xTHhOQnVHclVHREoybDZZL2gxanBI?=
 =?utf-8?B?MS8xVjhJenVSNHBmTEloOUJIdXhUa2J0QlEyQmVCbmZuVVNDOTRwcDJyVjky?=
 =?utf-8?B?U3Vyei9WQjlHZ2F5MGtIRU41cGgyMmpqV1hqT1l4VlIwVVlqbzN2ai9QQ210?=
 =?utf-8?B?ZENscVd3YWZyS0tNT3dCY2Zzek1qeXo5MXNaclFEMXExQVpPV0Y5SnQ2NnBX?=
 =?utf-8?B?UUhkVmUzeExYT3BoQ0FtejY2KzQ2cGhsdmRPUFNMWUoxTk9BVEFaWndVMmps?=
 =?utf-8?B?TithL0p5NUt2bG1wT3VodUdDaWZhWHlDWHBQcEZpc1BCVHpuSjVEeTltM28w?=
 =?utf-8?B?UFEvOVB6cTVZQ1lGaWIvSG5WQlVaaEZEdm1zRyt0U1M3eTBKRkZjQVhHeWR1?=
 =?utf-8?B?RVFkbDYrTUpyU0tscmR2N2dFZGJUYmh1VXlWUFUvRTl5NS9vbEhWZlFiNk9i?=
 =?utf-8?B?S0xuMnhTNjFieTVweE9MVnVnZjA5d1EwNEpxWFRVR3B4VFdnOVpBbnoyQU9i?=
 =?utf-8?B?UTNpNkNHa0Q3Unp0SEZYdXlHQTQ3K0k1b0doMmxBb0dwdittUUdIbVVZZlU2?=
 =?utf-8?B?cHRFRzg1Z2F0WVJRbWM3aEtFQnl0ZksrUHBCSkp1RmU0WWgrOW0vaG1zaGsz?=
 =?utf-8?B?SWxZRzdyOUZQRlNjcDVHMjlGd2NjZkQzQ3FIU3NNRlZ1a21QSmovWnV6VXlE?=
 =?utf-8?B?cDl0Q3VZbGIxN2dFZk1rN1dBbDF6eGJCZEhVaFNCQTFkYUZiWDdhb0VHSUVp?=
 =?utf-8?B?bDVtR3RDb0J6NlRoZW5QN1JmOU1uaUhaN2ovc1NXc1R4eDJVc2FMRDZjU3FX?=
 =?utf-8?B?WWttdVFwL2phRHpuY0h1azNEdExNSFpQYW9LTlg2VWV4cDQ2MzZxYmtmYnAx?=
 =?utf-8?B?SGFpbmVVS3E1MEVPQ1pKUXhKT1l1UWdNc2NOdkZOQ2I4QWpQUS8rUXJFS2VQ?=
 =?utf-8?B?eEVkbWt3bTBRMzNsV3BXZEQ2cE5KTmtlU3lRM0dUamoxOEE5Z2ZDaUxoSXNx?=
 =?utf-8?B?RmU4aVBDMkJwNk05c056YndCaTdON3Z5MlZNclBqenJtRVVXTFl3OVJBQnY5?=
 =?utf-8?B?L2grallla08yWkk0Tkh0Y2dtWEdGNmZ3ajMvcXZaK3pna2Rld1dVTEY2Skcx?=
 =?utf-8?B?bmlPR3hWMEp1M2JsaEg4VS9BdEpjdmFVWXNZS1NlNlRmUzNyaUZRYlFyZW1h?=
 =?utf-8?B?Vjg5bGt3TFRrbmc4amJXZTFGTmVyU05Yejk2V0gwaVNoaFlULzNsL1JDMFlz?=
 =?utf-8?B?Z01KK1RPQ0V3eGZjZ1lrNVZkK1RsUHRGQ0prR3hJYWZjTTFPYVFBMlk5UXN2?=
 =?utf-8?B?QTV2UGJoU0hHa1VUUFc5NmdncUZyRllCU25jb2RmcXNjY2MzbmxDWkFlZnBS?=
 =?utf-8?B?RlhmekJsaXBpMlZpN0NFQndoTERhdzBlcVkrSlNDemRlMWIzdnhvYVhERkZj?=
 =?utf-8?B?NEpBTTNub1YyRGJ1Z1JFSGJvWWhQMGtUcUs4aE5saVRQT0JoSmlTdE5aeldS?=
 =?utf-8?B?TTdxRHRDeFgvU3BLSHdJVkdyaVhDcHk5Tmc2ZkFBdEN4ZmtMYm5zVUkxVnBY?=
 =?utf-8?B?VmtyTjZ0V01xVWNvQ1BtM2ppcW5SVTJPcjduZVdkQzl5NjUrejA5VUxHYksy?=
 =?utf-8?B?U1I5dldkbDd0VkU3bHg3c1U0dVBLZUh1Qy9NUmkwdE1lZ1NNaXRLc0FBdjVO?=
 =?utf-8?B?WS9FeWEvSzlXTXdoaE8vUlJnVE5lWlByU21CaWVzQmhXYVVocGhkNHloSVNj?=
 =?utf-8?B?SFdvYXRSTmRHcStxRm04S1dtWFF1Z1BQdERjU2R2MGxjbFU0OEVCYUJoT0Zz?=
 =?utf-8?B?ZDRUMFAzTURGaU4waGNHN3l3a0Jad1FSakk5L2R0RFpPYk1Kbmd5T0xySys1?=
 =?utf-8?B?ekVlVVQ2NWpQTG1DT0Nsb2x0MmVBV3VhNWQwdlkwZ0Z1UDNmVmpPTXpxZ1Yy?=
 =?utf-8?B?ZVpFamZyQzR3OWlxWU1JWitVbklaUzNvT2lBaGlkMVZIeTV1T3pyMThvQ25v?=
 =?utf-8?B?MFprWjF5bWQ2Y29LVkZReXB4SndYMFNIUUVLbHFhNTZSLzRUYnc0Zk15M0NT?=
 =?utf-8?B?cWwzQ3NCUGM3T2tJVXI4NnUxVWpBVVJ1cU03ckVlYkNZTnA2NHpNQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <D77738AEE6918142A60FEDA1364F18DA@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: qd3e3Qo0Akv0E1Sk/5ss7mDH8J1ebyFaAqYMmFom+t9K1K6m41KlQReJmSRrLjikH02e4ZpqhTr8DHDPZQtlOHTt37jONVUj1uXKTkxFQ40vQ/pZZWz6G8MmeDwLds9SCPHz70GTsGPEM8Fm2D+e4Rg7teh2DCGYu1VsIViaETZ4G/qKWlqOaUekRdtbUVZPu2stETpq3YJbAQwarhdryZw5rrxx/ADkXGpFPdSWlniRm4c3yWiYBTYyLFY3yjawF4oXWswLlZv1+W+oNwSuozyqr8J8bhrL80jEns2ge5IOBDnH9PXBQm2Ns3W5KfT0dRvtj/G+CVDGRY3M2PiGtw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Olz2DkO4/AlvBdUOLbYf5ssxntOObRwdcjSRJRMQ93ETJ5ABUlfFONaMY2v9Jn4zz7yg5/+UoBo0qKvSY6uOQY0LdqghUGCN1erCqlKRbGVeCYvRVtBYWiUbLZxMjPDs0smLTSmZO5tQbO6tzvjbNe/m98WZhzUvN1kdgI5PDHDGo1MoAlKgou38oqEnIJUXgsnhn5X4mGFFhU022UQQufduahcho7KWDHx2XNXSf/qPTPKVNulWN+6o6kUcPO42YA1bAsdc+C56ibRpEawx/5X3j5c9zhJ5YGSVgNPNujueKL4OerltviR6p6wFZmwZLZ2tuN/9374m1B3FcfVfpiZwyPNRhyEPwk8DVrFsO0lm08aizbYB4Vw16CZ/h1V88GaGfENaWybB3Qd5D6UKtyQs3kh4KRKw/rXJe9Xzed7q9HzEpCX3H4VIsQLfDUvc2Vabn8VKn5Ql6FK+iZGT60iWVfzZPTM51IfkNKdUsBOvCH5sCur2WH9mHjL6xhfQ0FZMzgK39B/xGDZV8f9vEV1x5eppArtZJ+Z/ldA1qId7LZ7g0volPqKa1DOExxsE/n5YpxQN7qXr/yQx/tte+81+AmQHnY6xIYyr44jtoGI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA4PR10MB8301.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f280ae2-2983-4a41-daaa-08de7f89679e
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2026 16:15:25.8854 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RHBHE4zA8BDNvO0GunEOjB3etHasOTGZ6rENmQ/YEI3wTF9RdeX5fkVgsleOpTFbanYJm/II2rHenzXDol6XnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4594
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 malwarescore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2603110137
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEzNyBTYWx0ZWRfXxGCaphvYiA59
 lsEHl2sl9rD1w0GFKHIZawBjYhHBLkIAhncn5MzyR3wHzzwkxvL/zkNVAZlUcfCB6qmpAYD+/Rh
 zRJaGmxTWpNclgZ5VJ6ZHbMUi2p8WPwPItjG3muphLGZL4B05yQilHxUIatZZBBtGQC1ItOluNw
 2HEt04OSaVarMO7bd74BeV8iJukghWV1p7DFU4j1Bf//rFlLXysOkiSV/AVrGXu9qX4e2S6vQf6
 ph3KXE+hNunvf7RaWKofhJDZBGpwCVwZ7WtE7rE5McK4GarufwxVRdysPYiYMSG1hGrGVhw/sVg
 U5LLNDAzRnUCQmtOmJweke9yXS46jRvWfS1j2FD2S8pNEiZWKNasv2iAr+YW/P23Bq82ijDt4Ln
 17Pjwo6T9wLNWGVMtO0Tw7xZkXHwjOOu6EwBVYiJrK+DdHCwIVcwd8XEx8P+AlqfBIzb6PgFiTi
 rNqlo7Ch8lwPJXEMhH6G9gIVI5A6uES+va+HL+MY=
X-Authority-Analysis: v=2.4 cv=NvbcssdJ c=1 sm=1 tr=0 ts=69b19528 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117
 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=GoEa3M9JfhUA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22 a=BqU2WV_vvsyTyxaotp0D:22
 a=20KFwNOVAAAA:8 a=-MrvW-EqcapwHVrcNXQA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:13817
X-Proofpoint-GUID: QQVt0eRUo-MOVPkx2tpgrOyxeK_Xe24k
X-Proofpoint-ORIG-GUID: QQVt0eRUo-MOVPkx2tpgrOyxeK_Xe24k
Received-SPF: pass client-ip=205.220.177.32; envelope-from=jag.raman@oracle.com;
 helo=mx0b-00069f02.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

DQoNCj4gT24gTWFyIDExLCAyMDI2LCBhdCAxMjowOeKAr1BNLCBDw6lkcmljIExlIEdvYXRlciA8
Y2xnQHJlZGhhdC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8gSmFnLA0KPiANCj4gKyBKb2huDQo+
IA0KPj4+IGRpZmYgLS1naXQgYS9ody9yZW1vdGUvcHJveHkuYyBiL2h3L3JlbW90ZS9wcm94eS5j
DQo+Pj4gaW5kZXggNTA4MWQ2N2U3Zi4uZTkxNTY2NTA5ZiAxMDA2NDQNCj4+PiAtLS0gYS9ody9y
ZW1vdGUvcHJveHkuYw0KPj4+ICsrKyBiL2h3L3JlbW90ZS9wcm94eS5jDQo+Pj4gQEAgLTUyLDkg
KzUyLDIwIEBAIHN0YXRpYyB2b2lkIHNldHVwX2lycWZkKFBDSVByb3h5RGV2ICpkZXYpDQo+Pj4g
ICAgIFBDSURldmljZSAqcGNpX2RldiA9IFBDSV9ERVZJQ0UoZGV2KTsNCj4+PiAgICAgTVBRZW11
TXNnIG1zZzsNCj4+PiAgICAgRXJyb3IgKmxvY2FsX2VyciA9IE5VTEw7DQo+Pj4gKyAgICBpbnQg
cmV0ID0gMDsNCj4+PiANCj4+PiAtICAgIGV2ZW50X25vdGlmaWVyX2luaXQoJmRldi0+aW50ciwg
MCk7DQo+Pj4gLSAgICBldmVudF9ub3RpZmllcl9pbml0KCZkZXYtPnJlc2FtcGxlLCAwKTsNCj4+
PiArICAgIHJldCA9IGV2ZW50X25vdGlmaWVyX2luaXQoJmRldi0+aW50ciwgMCk7DQo+Pj4gKyAg
ICBpZiAocmV0IDwgMCkgew0KPj4+ICsgICAgICAgIGVycm9yX3JlcG9ydCgiRmFpbGVkIHRvIGlu
aXQgaW50ciBub3RpZmllcjogJXMiLCBzdHJlcnJvcigtcmV0KSk7DQo+PiBzZXR1cF9pcnFmZCgp
IHNob3VsZCBpZGVhbGx5IHByb3BhZ2F0ZSB0aGUgZXJyb3IgdXAgdGhlIHN0YWNrLg0KPj4gQnV0
IGh3L3JlbW90ZS9wcm94eS5jIGlzIHBsYW5uZWQgZm9yIHJlbW92YWwgYXMgaXQgaXMgc3VwZXJz
ZWRlZA0KPj4gYnkgdmZpby11c2VyLCBzbyB3ZSBkb27igJl0IG5lZWQgdG8gZG8gaXQuDQo+IA0K
PiBJbiB0aGF0IGNhc2UsIGNvdWxkIHlvdSBwbGVhc2Ugc2VuZCBhbiB1cGRhdGUgb2YgZG9jcy9h
Ym91dC9kZXByZWNhdGVkLnJzdA0KPiB0byBkZXByZWNhdGUgTXVsdGktcHJvY2VzcyBRRU1VID8N
Cg0KU291bmRzIGdvb2QsIENlZHJpYy4gV2lsbCBkby4NCg0KPiANCj4gVGhhbmtzLA0KPiANCj4g
Qy4NCj4gDQoNCg==

