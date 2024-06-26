Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADE33C3064D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 13:35:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMSns-0004vJ-Uc; Wed, 26 Jun 2024 09:35:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMRUH-0000h0-EX; Wed, 26 Jun 2024 08:10:57 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <calebs@us.ibm.com>)
 id 1sMRUC-0003C2-HM; Wed, 26 Jun 2024 08:10:57 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QBR0WZ018168;
 Wed, 26 Jun 2024 12:10:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
 :to:cc:subject:date:message-id:references:in-reply-to
 :content-type:mime-version; s=pp1; bh=BLpyARcSqtiVwQB3FJ7NzX25SM
 HrG7bAaa7CEwT4+1g=; b=j9y/txSgN+Yf67Pqi0Grh1sarsIVAmz1p371xij4+L
 lQAwlg98uM0YS3N0o2n6osihG2OBjjX8pYjs0C45jxODUhSI/y8lxlRKaFbML5oF
 4yp3JMGa7kE2hvVOkM0nuFwh0UvrXTJ9RJyI/vWgYAYv/Y2mzRZLvKMvB70HVPmP
 hRUVxq0DL/1l7onAATxr7DQtnccZaeuRxIXFi5hXwTw/kEz+w5Ivy+/nMPogM8mw
 hZ0qKTF10YF/MW0qha1ezKxdvPVLrNDl4EfND0EH3vGT1450zIumsETpGKOReOyV
 f/yiXSjMz4zMPIbLizeu9hyTmf0NqOkVlIlRo+nmiqjA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400hq6858p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 12:10:40 +0000 (GMT)
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45QCAdO6016748;
 Wed, 26 Jun 2024 12:10:40 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com
 (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400hq6858m-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Jun 2024 12:10:39 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=egaLoTWCfmACmWSfs8hvOHMuFcbzr8XsXu/ctrjA9UB4aANNW+hv4GOR5troi+KSgBAoFA4msAqRGTnZ76J/Kc0hIRSpvW/b1JMQIsG+P6wHOESGLMJbqoolUQBjhrOK2Z6y9ouuUVMiKc/H65eOIUtt0B5TtauBG9Bg5hldlNgxt7SU3KGgfPWOFYyWg4AT3qJyzAEDj2Q2oV6umsQZjZj719H6bFSuZI2krU9S745YyB7V80LRHGkleia04d127A/VTAsNNALwWh6uZFCtaOPdXzYoseVF8IbqPv53etNOLV2sqOvqcCVSTWptPuU4PxE8zhT9+LTtebCo0SdmUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLpyARcSqtiVwQB3FJ7NzX25SMHrG7bAaa7CEwT4+1g=;
 b=EVaj31sn25Ya8XHhY2BTW90rcwCLEGSNDeE853Ob2Xv7WKFqorx/z2XkJmC9xBwNLy7qL8z/UMLcxKAwRpET3r16ctCXPIcpGVlgE3oTy+5vuOMob20tQY3DdCkP3/U0v3gNn4S06CvvSFTyu9IvFvadbBM1A1cP5M1XX3POJDB88fH8XOFU6p9q4/9SZdkjw9toD8pktLIbRLqXyo3FlhJ1QxHpKVv2kzVdyGOqhDVizmdd5Nlt3ZzyFXKeOhtVRC4Bd55BXyGmLpbvW49MT7Frss2pgDswepl+6DTsAlzITxDrZfQtS1Lv9650LwKvc6L0GzUb/8n369RsjSxz3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=us.ibm.com; dmarc=pass action=none header.from=us.ibm.com;
 dkim=pass header.d=us.ibm.com; arc=none
Received: from PH0PR15MB4720.namprd15.prod.outlook.com (2603:10b6:510:9a::6)
 by BY3PR15MB4932.namprd15.prod.outlook.com (2603:10b6:a03:3c7::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.34; Wed, 26 Jun
 2024 12:10:37 +0000
Received: from PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4]) by PH0PR15MB4720.namprd15.prod.outlook.com
 ([fe80::fdd1:5ceb:28e8:e1b4%5]) with mapi id 15.20.7698.025; Wed, 26 Jun 2024
 12:10:37 +0000
From: CALEB SCHLOSSIN <calebs@us.ibm.com>
To: Chalapathi V <chalapathi.v@linux.ibm.com>, "qemu-devel@nongnu.org"
 <qemu-devel@nongnu.org>
CC: "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, "fbarrat@linux.ibm.com"
 <fbarrat@linux.ibm.com>,
 "npiggin@gmail.com" <npiggin@gmail.com>, "clg@kaod.org" <clg@kaod.org>,
 Chalapathi V <Chalapathi.V@ibm.com>,
 "saif.abrar@linux.ibm.com" <saif.abrar@linux.ibm.com>, Dan Tan
 <dantan@us.ibm.com>, "milesg@linux.ibm.com" <milesg@linux.ibm.com>
Subject: Re: [PATCH v5 1/6] ppc/pnv: Remove ppc target dependency from
 pnv_xscom.h
Thread-Topic: [PATCH v5 1/6] ppc/pnv: Remove ppc target dependency from
 pnv_xscom.h
Thread-Index: AQHax6gLwk3M0r9+uk6RoTQYhnxiU7HZ85bA
Date: Wed, 26 Jun 2024 12:10:37 +0000
Message-ID: <PH0PR15MB47206EEE6C375511CBA8F9E9E1D62@PH0PR15MB4720.namprd15.prod.outlook.com>
References: <20240626090528.812-1-chalapathi.v@linux.ibm.com>
 <20240626090528.812-2-chalapathi.v@linux.ibm.com>
In-Reply-To: <20240626090528.812-2-chalapathi.v@linux.ibm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR15MB4720:EE_|BY3PR15MB4932:EE_
x-ms-office365-filtering-correlation-id: fa5e0a64-8b05-4a6f-13fc-08dc95d8fd32
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0; ARA:13230038|366014|376012|1800799022|38070700016;
x-microsoft-antispam-message-info: =?us-ascii?Q?LzkIL5wzfL4NGNYvSnOs3D8xmdru9T9OOODDxWdWctvP/pIfhb9DB63x4j7y?=
 =?us-ascii?Q?4ufezQwtqgMxaCZUnWF8nP/B8W6YZBk4ZhbI76Gzx51bll/qdDpeGhUs3exf?=
 =?us-ascii?Q?X9P4coB7sF87kqqQhxd3AP5kebAsCnx9oElTq980T567HtFBYPLFzxmASd5H?=
 =?us-ascii?Q?a01UZ6KnaiyIBoI9JDWWxhYALkf62eUqkapbtl0p8IbWur3eozASeCj4Pf6d?=
 =?us-ascii?Q?9gp/mmlOdhikbhtgEqOjFd8F+oZDPR5S6JZd4WUn0Suhl2HvKjJ9/d5BLIan?=
 =?us-ascii?Q?xZsLVHl0TJBHijsVlYg5RkFClmcMaZgktcc61+PjZ9w2jpbdze5a8jn8PArc?=
 =?us-ascii?Q?RaLId4xEOII1xY1sWWqjCEswpf9dtTnxTD7SPkBHQtztTsiSZSJx8NLOvJu5?=
 =?us-ascii?Q?il4Cbjk7ENT4fplytY9IF38cCxb16jabZWpok8TlnVNEGcLPEr7epLdXOQ2a?=
 =?us-ascii?Q?pu79GeXzWY8KPb6mgXhN8678zY4ANuij7fUq2/o0c6mT5pAFSgwJ8ZrdA5Bf?=
 =?us-ascii?Q?0IB9c/D4d+Cfz3d0eaRFDJsPE9WqIWTsZT9JUHf5HB1AC+U+D2k/0z+2PMIa?=
 =?us-ascii?Q?h7/J11007UmOKjRu8GKdO0of+FSX/fQ3Ygg2vc0QKCxH3B5Q0G3LwvRlX6RZ?=
 =?us-ascii?Q?eQkNBNwX0bzAUJZEiVkM205X8F0kePhrmzJmMBGy56FOEzTh7VmTV+XD6iCu?=
 =?us-ascii?Q?bgVE190fbrtKQNBhDfgtZsJXOo1KWuco5m2KY13JnrU0cMhfw70m4LMIfjMh?=
 =?us-ascii?Q?7Kb756p/LuB6NfOVB8EwA7qa+cc85fS9LdZMb0PVwTGprvZ+SkM6N+B2W8O6?=
 =?us-ascii?Q?tpryxP+VLm+5WzjJBHN7/kPjB4eXlN2zWVUfa7gQXJu9f6OFSAHvIZnZGHkT?=
 =?us-ascii?Q?8MMJ1cD+RTnLbZVJui+8xDR8VDsJi76gncvEYbdGn4GNsbDqMfRbDLYio6uX?=
 =?us-ascii?Q?+7VD/sZEGxsDKAmWCU1MrkoE9DZljRT4HqoDmIfRXIgZrMMUfj/eBnVtdyt3?=
 =?us-ascii?Q?PmbIvY1u15tgTSaBqRBybohHQZtD2LAKjBmG8VXQAJq5cl0Z8C9LO6i915ID?=
 =?us-ascii?Q?ShJ42UlENfhpNCtm3oy5CkkiKBUOFInHSrb3kKMCMukJ8y3dzEKPWWkbS/xY?=
 =?us-ascii?Q?7aop3P+Ux94Rzq+AxWUwhFHkj/NbDR1+Q/hiCasIM4QtXhNXrRAWCBsIugSD?=
 =?us-ascii?Q?WukgX5T+DcrVwFxnsYP0Fn3uGnUeafCyYM7RdWMPmokmDDEtgF9qkNjL5+h2?=
 =?us-ascii?Q?1mKuGU22VopWDL6VUgHo/af717A0K/CSh9tXjmWB2QJXyrwmD0Ok1yfGC2QK?=
 =?us-ascii?Q?Z8Alexhi4zXLQ+UDeH1gIuZXm9suNl8FrfFjwz0bxm4Q9IB8X43fwXImB3fs?=
 =?us-ascii?Q?81etzSo=3D?=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR15MB4720.namprd15.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230038)(366014)(376012)(1800799022)(38070700016); DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?bzYsUIR388Rfm7vkmQqgY/QndCFz6NOoHXzfiz3u3/hPeOkrwZZ/hQAv4OHq?=
 =?us-ascii?Q?rh2BtrRsezN1qcnQaH996Sof3ykHiW7KYp1vgnGDt0d4N77wnyL743yLih/w?=
 =?us-ascii?Q?A2TCsm2ylgh79UW3QzxQpmh0JxaZ5ts56Q7BCrCpqQcdtEUREXnft8fGJ6RZ?=
 =?us-ascii?Q?eN2NaF141bMlUQ2f0YviyI79R5QBDEjL2UWxJSK9RpBx959rxUWHBYrRVNZP?=
 =?us-ascii?Q?WQfcYbvcZmCl5CM2iymFU+IBW7yg0SLB9mZap1x20PyQkhhTGq2CRsYrBT3s?=
 =?us-ascii?Q?NIBvCF+dAk1BdqJeqSqhFG2uhP8qp1U6C92XoU74KKCGUWEpqgy03iBivi5T?=
 =?us-ascii?Q?IsiesKz89QqM63R8/V4CVr12Xaf9j1LFnJs6i6zWwpnN2OO1ZuRDplOlw19W?=
 =?us-ascii?Q?9tDFxVa2ZWBptQYLQLUIUYp9MWBeQ9Zqj5QKHAiFHQ7zF3/L3m68lmvi8HMx?=
 =?us-ascii?Q?71uzdN1EQ3kFwnWPbo6lcO+jkpfDu7pNhxewOMt69pPF5dktAqirT+qbTDSN?=
 =?us-ascii?Q?7bZQIJmkqj8oHYGkH5Ggax8vChXgLwO9uz/L4nLHaF+N+9cvzz88z76YPYff?=
 =?us-ascii?Q?OE0Um6JoDzKEdHFdfW37ebYCAaVpeuPtHbbwG6D+zwkegqekV1kV7QYY/AT7?=
 =?us-ascii?Q?LiT9Oc0UE1t+lp+Nqiqm/IzamJsg9UseMJaCDEgI8VG4h/OnkY77DutPyy+2?=
 =?us-ascii?Q?SyHjXPeXWAuJpZ3BlcRtNQf99Pne3Yfq9UEADEpS7dnbaOrQPdhKL/f4bb7S?=
 =?us-ascii?Q?xzlEdoHZtKdNM5WEhMZfz8ROnZLnf4gcseyxKNsX2DXC9bzeBYOfqC/Dx3KK?=
 =?us-ascii?Q?KYz9+aFYGmgGfPsHSj+dUWE4IhFez7OzFE95kmlpGLpVk1VxRyj3vTLxrK6z?=
 =?us-ascii?Q?n0FN69BD9bgNBpuYDHrd6qOF6n5mSCotKvb2Ay777xBAb9b3dWmfh05Xv1mM?=
 =?us-ascii?Q?+n46mq1hWKo+DiicI0UZutkNN2+RoPBDYwhiWK4UZIFpk50RLhIn8WXDQwzz?=
 =?us-ascii?Q?KD27kVhIY8E5RNIjJht6Q28j6Na1GaXuMDAu6vWtegY/QdJukeGlCuwN1z4s?=
 =?us-ascii?Q?V8aehmWFWbDB+UHkdZ5VzoDGy8Sn/UmlS8Tm3TUolhALmbmn70a/5KH5q289?=
 =?us-ascii?Q?ERVgFR32i1boYrVSTWYzKGS9eH026b6rgOus7jkuEJQKCbondvyex8qGhTgM?=
 =?us-ascii?Q?Lg6CFXw8S+zVOYLA+a0LnSW/fkP1DG+DxTQkzVbE/ffHjnou8IA33hfqKmWu?=
 =?us-ascii?Q?QlqnVIhTRe+MqiWHqUXJ5ZAdyAYN94BXcKEOsyEl1u9zx1MNofg+ScJK1UG3?=
 =?us-ascii?Q?3rXCiptHpoD6fe5JYqYO6UNmTfwyToaauuycEjMHQMtIlt8joc+ZUJ1MFW+R?=
 =?us-ascii?Q?sIK49Pyll4lsIhkeSyvCtFwKaDyhCD/wkr0gJISGXKmkYVhLU13w94N7gCae?=
 =?us-ascii?Q?PKoUjquZUXNR7JEwwcqtdbLdczoYhZfrFtShBraMQAy+E+uaAsjh76NO3dfF?=
 =?us-ascii?Q?2MIItUOaCLKvMCZqYJOdiihWpV1IhqXVy0li2U5+Ll1jkDZhz6oJuPLRqihy?=
 =?us-ascii?Q?lWj/o9BHna/H/wnYl5w=3D?=
Content-Type: multipart/alternative;
 boundary="_000_PH0PR15MB47206EEE6C375511CBA8F9E9E1D62PH0PR15MB4720namp_"
MIME-Version: 1.0
X-OriginatorOrg: us.ibm.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR15MB4720.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5e0a64-8b05-4a6f-13fc-08dc95d8fd32
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2024 12:10:37.2633 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: fcf67057-50c9-4ad4-98f3-ffca64add9e9
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1kD7I7XxsJvfYHkzTmj6+HIoEKrWnAMo20rsg90Vm66mbwbQJDTi4PUfOYPk5lro2duj11njo0JOi/6A9jT+Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB4932
X-Proofpoint-GUID: 1tNtmvsxStnQ7bOHHWjQwYRaykkxEKf6
X-Proofpoint-ORIG-GUID: 7pB9ZwYGjO5427gq-JtZx8uBAgORDtlM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 priorityscore=1501 spamscore=0 phishscore=0 mlxscore=0 suspectscore=0
 clxscore=1011 mlxlogscore=999 lowpriorityscore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260090
Received-SPF: pass client-ip=148.163.156.1; envelope-from=calebs@us.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Wed, 26 Jun 2024 09:35:15 -0400
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

--_000_PH0PR15MB47206EEE6C375511CBA8F9E9E1D62PH0PR15MB4720namp_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

On 6/26/24 11:05 AM, Chalapathi V wrote:
> In this commit target specific dependency from include/hw/ppc/pnv_xscom.h
> has been removed so that pnv_xscom.h can be included outside hw/ppc.
>
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>


Reviewed-by: Caleb Schlossin <calebs@linux.vnet.ibm.com>

Thanks,
Caleb Schlossin
________________________________
From: Chalapathi V <chalapathi.v@linux.ibm.com>
Sent: Wednesday, June 26, 2024 4:05 AM
To: qemu-devel@nongnu.org <qemu-devel@nongnu.org>
Cc: qemu-ppc@nongnu.org <qemu-ppc@nongnu.org>; fbarrat@linux.ibm.com <fbarr=
at@linux.ibm.com>; npiggin@gmail.com <npiggin@gmail.com>; clg@kaod.org <clg=
@kaod.org>; CALEB SCHLOSSIN <calebs@us.ibm.com>; Chalapathi V <Chalapathi.V=
@ibm.com>; chalapathi.v@linux.ibm.com <chalapathi.v@linux.ibm.com>; saif.ab=
rar@linux.ibm.com <saif.abrar@linux.ibm.com>; Dan Tan <dantan@us.ibm.com>; =
milesg@linux.ibm.com <milesg@linux.ibm.com>
Subject: [PATCH v5 1/6] ppc/pnv: Remove ppc target dependency from pnv_xsco=
m.h

In this commit target specific dependency from include/hw/ppc/pnv_xscom.h
has been removed so that pnv_xscom.h can be included outside hw/ppc.

Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
---
 include/hw/ppc/pnv_xscom.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
index 6209e18492..c8dd42bffd 100644
--- a/include/hw/ppc/pnv_xscom.h
+++ b/include/hw/ppc/pnv_xscom.h
@@ -21,9 +21,9 @@
 #define PPC_PNV_XSCOM_H

 #include "exec/memory.h"
-#include "hw/ppc/pnv.h"

 typedef struct PnvXScomInterface PnvXScomInterface;
+typedef struct PnvChip PnvChip;

 #define TYPE_PNV_XSCOM_INTERFACE "pnv-xscom-interface"
 #define PNV_XSCOM_INTERFACE(obj) \
--
2.39.3


--_000_PH0PR15MB47206EEE6C375511CBA8F9E9E1D62PH0PR15MB4720namp_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html>
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<style type=3D"text/css" style=3D"display:none;"> P {margin-top:0;margin-bo=
ttom:0;} </style>
</head>
<body dir=3D"ltr">
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
On 6/26/24 11:05 AM, Chalapathi V wrote:<br>
&gt; In this commit target specific dependency from include/hw/ppc/pnv_xsco=
m.h<br>
&gt; has been removed so that pnv_xscom.h can be included outside hw/ppc.<b=
r>
&gt;<br>
&gt; Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
<br>
<br>
Reviewed-by: Caleb Schlossin &lt;calebs@linux.vnet.ibm.com&gt;</div>
<div class=3D"elementToProof" style=3D"font-family: Arial, Helvetica, sans-=
serif; font-size: 10pt; color: rgb(0, 0, 0);">
<br>
</div>
<div id=3D"Signature">
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Thanks,</div>
<div style=3D"font-family: Arial, Helvetica, sans-serif; font-size: 10pt; c=
olor: rgb(0, 0, 0);">
Caleb Schlossin</div>
</div>
<div id=3D"appendonsend"></div>
<hr style=3D"display:inline-block;width:98%" tabindex=3D"-1">
<div id=3D"divRplyFwdMsg" dir=3D"ltr"><font face=3D"Calibri, sans-serif" st=
yle=3D"font-size:11pt" color=3D"#000000"><b>From:</b> Chalapathi V &lt;chal=
apathi.v@linux.ibm.com&gt;<br>
<b>Sent:</b> Wednesday, June 26, 2024 4:05 AM<br>
<b>To:</b> qemu-devel@nongnu.org &lt;qemu-devel@nongnu.org&gt;<br>
<b>Cc:</b> qemu-ppc@nongnu.org &lt;qemu-ppc@nongnu.org&gt;; fbarrat@linux.i=
bm.com &lt;fbarrat@linux.ibm.com&gt;; npiggin@gmail.com &lt;npiggin@gmail.c=
om&gt;; clg@kaod.org &lt;clg@kaod.org&gt;; CALEB SCHLOSSIN &lt;calebs@us.ib=
m.com&gt;; Chalapathi V &lt;Chalapathi.V@ibm.com&gt;; chalapathi.v@linux.ib=
m.com
 &lt;chalapathi.v@linux.ibm.com&gt;; saif.abrar@linux.ibm.com &lt;saif.abra=
r@linux.ibm.com&gt;; Dan Tan &lt;dantan@us.ibm.com&gt;; milesg@linux.ibm.co=
m &lt;milesg@linux.ibm.com&gt;<br>
<b>Subject:</b> [PATCH v5 1/6] ppc/pnv: Remove ppc target dependency from p=
nv_xscom.h</font>
<div>&nbsp;</div>
</div>
<div class=3D"BodyFragment"><font size=3D"2"><span style=3D"font-size:11pt;=
">
<div class=3D"PlainText">In this commit target specific dependency from inc=
lude/hw/ppc/pnv_xscom.h<br>
has been removed so that pnv_xscom.h can be included outside hw/ppc.<br>
<br>
Signed-off-by: Chalapathi V &lt;chalapathi.v@linux.ibm.com&gt;<br>
---<br>
&nbsp;include/hw/ppc/pnv_xscom.h | 2 +-<br>
&nbsp;1 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h<br>
index 6209e18492..c8dd42bffd 100644<br>
--- a/include/hw/ppc/pnv_xscom.h<br>
+++ b/include/hw/ppc/pnv_xscom.h<br>
@@ -21,9 +21,9 @@<br>
&nbsp;#define PPC_PNV_XSCOM_H<br>
&nbsp;<br>
&nbsp;#include &quot;exec/memory.h&quot;<br>
-#include &quot;hw/ppc/pnv.h&quot;<br>
&nbsp;<br>
&nbsp;typedef struct PnvXScomInterface PnvXScomInterface;<br>
+typedef struct PnvChip PnvChip;<br>
&nbsp;<br>
&nbsp;#define TYPE_PNV_XSCOM_INTERFACE &quot;pnv-xscom-interface&quot;<br>
&nbsp;#define PNV_XSCOM_INTERFACE(obj) \<br>
-- <br>
2.39.3<br>
<br>
</div>
</span></font></div>
</body>
</html>

--_000_PH0PR15MB47206EEE6C375511CBA8F9E9E1D62PH0PR15MB4720namp_--

