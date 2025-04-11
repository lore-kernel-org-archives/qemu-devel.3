Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D4EC369A2
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 19:14:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3JoS-00037I-9X; Fri, 11 Apr 2025 15:13:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u3JoP-00036l-Ll; Fri, 11 Apr 2025 15:13:13 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1u3JoN-0005lF-NT; Fri, 11 Apr 2025 15:13:13 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BII4wU015164;
 Fri, 11 Apr 2025 19:13:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=gRyB2AyA86f6u3Ww1LHnAXelXV6aBH
 uzGS/2U0Xq3js=; b=qlB5gLTTaakQr9WKdQSjrhOD0rnLejypAqJFFClqsAlohh
 EGSoJRnD9s+En2WdT9Jbky5IDlyJ19AmSi6Dxj7Z0gL2aK95gXhhgCGJnT10N8mh
 UeDSc5zCPm6fNDz+3oYi739O8KukfWzFiS+O6pthLBev802dDUNkrTXkmZ5L6tjc
 av2DHoSystfNXLjo/1ZU2v6y/+XjzlnQQYLkY92SC1WNfJXOSkuMxKguXAz0948+
 v+yTp7m4QAPouWclRARakt6SpbcJOTyhw6uhCxSZBZYTpVaNTNbse4kN1pB38oiF
 tRNhB1UsZMSIAb342AHgp9jkvXqkIs9/O4uieA3A==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y4gqhjr5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 19:13:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BIdcVL018432;
 Fri, 11 Apr 2025 19:13:06 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m4a4g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 11 Apr 2025 19:13:06 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 53BJD5wT31589028
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 11 Apr 2025 19:13:06 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4BC85803F;
 Fri, 11 Apr 2025 19:13:05 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A8F8558060;
 Fri, 11 Apr 2025 19:13:04 +0000 (GMT)
Received: from [9.61.251.143] (unknown [9.61.251.143])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 11 Apr 2025 19:13:04 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------6gDuyVAED8xb2bbyIIt5W3bq"
Message-ID: <6ed74cd8-63c3-43f9-9f7b-7b8d8047cff1@linux.ibm.com>
Date: Fri, 11 Apr 2025 12:13:02 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 12/24] hw/s390x/ipl: Add IPIB flags to IPL Parameter
 Block
To: Zhuoying Cai <zycai@linux.ibm.com>, thuth@redhat.com,
 richard.henderson@linaro.org, david@redhat.com, pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
References: <20250408155527.123341-1-zycai@linux.ibm.com>
 <20250408155527.123341-13-zycai@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20250408155527.123341-13-zycai@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: klCyiOK0HI5ercMbCXo8mE6R1VQAiQsT
X-Proofpoint-ORIG-GUID: klCyiOK0HI5ercMbCXo8mE6R1VQAiQsT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_07,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=982 bulkscore=0
 adultscore=0 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015
 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110122
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This is a multi-part message in MIME format.
--------------6gDuyVAED8xb2bbyIIt5W3bq
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


...snip...
>   
> diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
> index b8e7d1da71..2355fcecbb 100644
> --- a/include/hw/s390x/ipl/qipl.h
> +++ b/include/hw/s390x/ipl/qipl.h
> @@ -23,6 +23,9 @@
>   #define MAX_CERTIFICATES 64
>   #define CERT_MAX_SIZE     (1024 * 8)
>   
> +#define DIAG308_IPIB_FLAGS_SIPL 0x40
> +#define DIAG308_IPIB_FLAGS_IPLIR 0x20
> +

nit: We have a diag308 flag defined here 
https://github.com/qemu/qemu/blob/master/hw/s390x/ipl.h#L22. It would be 
easier if we had the flags defined in one place.

>   /*
>    * The QEMU IPL Parameters will be stored at absolute address
>    * 204 (0xcc) which means it is 32-bit word aligned but not
> @@ -104,7 +107,8 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
>   union IplParameterBlock {
>       struct {
>           uint32_t len;
> -        uint8_t  reserved0[3];
> +        uint8_t  hdr_flags;
> +        uint8_t  reserved0[2];
>           uint8_t  version;
>           uint32_t blk0_len;
>           uint8_t  pbt;
--------------6gDuyVAED8xb2bbyIIt5W3bq
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix"><font face="monospace">...snip...</font><br>
    </div>
    <div class="moz-cite-prefix"><span style="white-space: pre-wrap">
</span></div>
    <blockquote type="cite"
      cite="mid:20250408155527.123341-13-zycai@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre"> 
diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index b8e7d1da71..2355fcecbb 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -23,6 +23,9 @@
 #define MAX_CERTIFICATES 64
 #define CERT_MAX_SIZE     (1024 * 8)
 
+#define DIAG308_IPIB_FLAGS_SIPL 0x40
+#define DIAG308_IPIB_FLAGS_IPLIR 0x20
+</pre>
    </blockquote>
    <p><font face="monospace">nit: We have a diag308 flag defined here
        <a class="moz-txt-link-freetext" href="https://github.com/qemu/qemu/blob/master/hw/s390x/ipl.h#L22">https://github.com/qemu/qemu/blob/master/hw/s390x/ipl.h#L22</a>. It
        would be easier if we had the flags defined in one place. </font><br>
    </p>
    <blockquote type="cite"
      cite="mid:20250408155527.123341-13-zycai@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
 /*
  * The QEMU IPL Parameters will be stored at absolute address
  * 204 (0xcc) which means it is 32-bit word aligned but not
@@ -104,7 +107,8 @@ typedef struct IplBlockQemuScsi IplBlockQemuScsi;
 union IplParameterBlock {
     struct {
         uint32_t len;
-        uint8_t  reserved0[3];
+        uint8_t  hdr_flags;
+        uint8_t  reserved0[2];
         uint8_t  version;
         uint32_t blk0_len;
         uint8_t  pbt;
</pre>
    </blockquote>
  </body>
</html>

--------------6gDuyVAED8xb2bbyIIt5W3bq--


