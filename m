Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E45EFD8769
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 13:18:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2UJ0-00074i-Pe; Tue, 17 Mar 2026 09:17:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UIZ-00072p-3I; Tue, 17 Mar 2026 09:17:30 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1w2UIV-00024e-Rn; Tue, 17 Mar 2026 09:17:26 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62H71Xnm382519; Tue, 17 Mar 2026 13:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=+46KIw
 lkgn1KriOlEaYLHYijVeoJxWZO8UZK3p2SrEQ=; b=UyMY+nEw3ju3uceTldaKbp
 573PXJMNrZUwQnJwJS4bcAsRE6+j+/ej5G5JvfmuefKE7rKAABkwq5AiR88pEmTY
 NkY9dz2C8+tDcvbwhnlCg/bMGonRD7Ci9cCXo6j+/vyfkBBysIFYGHsFS5oTflc8
 yNNHNJrcmn55N/RbfVSiyAroiK/RiQMxr7O++kxGrNFVYEe4HjieJN31PhpNTpJt
 KlXXy7zY+dVHM30FZLo7Wi1+yp2P1nv2/3fR+KQZ6C6y7qkU/bxmIoExaNeBxcTS
 l1BXmydiuVX9v9qx9/eX6LlYv8pR0KD9VIPF+U+mJXS/HakqQvZGp8VOabhqYGCg
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvyaucb8r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:17:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HB0gMs013987;
 Tue, 17 Mar 2026 13:17:19 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwjcy1c4w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 17 Mar 2026 13:17:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62HDHIZ826280644
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 17 Mar 2026 13:17:18 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 18A655805A;
 Tue, 17 Mar 2026 13:17:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B811758054;
 Tue, 17 Mar 2026 13:17:16 +0000 (GMT)
Received: from [9.47.158.152] (unknown [9.47.158.152])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 17 Mar 2026 13:17:16 +0000 (GMT)
Message-ID: <c20e2bf9-6856-49e4-84a7-4e9e1745b503@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:17:16 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] hw/tpm: Add TPMIfClass::ppi_enabled field
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260317120241.16320-1-philmd@linaro.org>
 <20260317120241.16320-3-philmd@linaro.org>
Content-Language: en-US
From: Stefan Berger <stefanb@linux.ibm.com>
In-Reply-To: <20260317120241.16320-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExNyBTYWx0ZWRfX0NEiPpA/OR/H
 AP0tfm9H7aIZIW95ZJh7CZCtBr0mze6x+FLG1yzH6kfcWvp2/BkRUzsiC6r+ZerX78R7oJgWaNY
 ywCNAsktBX9rX5ueN07o8Qq528EF2j+/ZU+qr/dFIIJZ09MpfMBBWnjonq4JpxgW0p3F1W5bLzB
 ZRwQnKKBmpOE+sP843TDGUdN0x7rqjL6NzuVDDFYKx5g9uv1+6OjfTByFQDBCLabJhrvIq7yD27
 HZnEXIgqSwqYgbdu7R20OGn+e9lSOUo7mmgvB1iFKHN0fDLf536mVwJbHQUmU1aYVZdBMB1Keo3
 TjQMgyfFg+g+hx8xURiDWdgjI149xDy8HQ+uMpwEZB5WsA4Jx/mG7CftuL7upUT05T3k4ZWVw5L
 5rMGc79TOTI1sLafS5xgp/dtoaXiANzxePxpr6HaPpobkH9/5DXVNtxbVjf0W5jfR15Wc3auZCU
 qXFSkLI3/uqnKxeoPtQ==
X-Authority-Analysis: v=2.4 cv=GIQF0+NK c=1 sm=1 tr=0 ts=69b95460 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=KKAkSRfTAAAA:8
 a=VnNF1IyMAAAA:8 a=M8p99k39Wi7gh_M0XKMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: TRFlswknGCmcKPwFJ6IzBq96uwY83zj7
X-Proofpoint-GUID: SUtOiuzpnomAnamnSO3NP-0zPkUcjdwF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0 malwarescore=0
 phishscore=0 impostorscore=0 suspectscore=0 adultscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603170117
Received-SPF: pass client-ip=148.163.158.5; envelope-from=stefanb@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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



On 3/17/26 8:02 AM, Philippe Mathieu-Daudé wrote:
> Each TMP derived device has a @ppi_enabled field, itself

TPM?

> exposed as a QOM property. External layers (like the ACPI
> subsystem) wanting to know whether a device implements PPI
> has to check for the QOM property available. This can be
> simplified by declaring a single field in the TPM interface.
> 
> Here we add such field to TPMIfClass, before converting each
> TPM devices to use it in the following commits.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/system/tpm.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/include/system/tpm.h b/include/system/tpm.h
> index b90dd4e8cb0..9458ad6668a 100644
> --- a/include/system/tpm.h
> +++ b/include/system/tpm.h
> @@ -43,6 +43,7 @@ struct TPMIfClass {
>       enum TpmModel model;
>       void (*request_completed)(TPMIf *obj, int ret);
>       enum TPMVersion (*get_version)(TPMIf *obj);
> +    bool ppi_enabled;
>   };
> 
>   #define TYPE_TPM_TIS_ISA            "tpm-tis"
> @@ -84,6 +85,9 @@ static inline bool tpm_ppi_enabled(TPMIf *ti)
>       if (!ti) {
>           return false;
>       }
> +    if (TPM_IF_GET_CLASS(ti)->ppi_enabled) {
> +        return true;
> +    }
>       return object_property_get_bool(OBJECT(ti), "ppi", &error_abort);
>   }
> 

Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>


