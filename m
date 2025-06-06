Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1B0BC5AD49
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Jun 2025 14:49:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNYNG-0007gz-Dn; Fri, 06 Jun 2025 10:48:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNYNE-0007gq-Ig
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:48:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jhkim@linux.ibm.com>)
 id 1uNYNC-00047V-DT
 for qemu-devel@nongnu.org; Fri, 06 Jun 2025 10:48:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556D9HK2032442;
 Fri, 6 Jun 2025 14:48:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=O4lrrgKq+PYtRwcP7zzyDBzoq00m+0
 jCtp5mTsM/rpU=; b=rFuqljqUQHYi6+JeObNFXuNcxCktkgFDtcGW6LijLCJRve
 8mXl+xY1P380IfBHE37qjEuDZ8xuMiWZN5iSe7kF/a7txJpkpxk15WOknp79l823
 v8uySMO35fc/MePAOSrMz+3bqK90LWfWOPyB6ey6iZi4swRchv/Hclwf6cQnTEHu
 BYaiXLcqAXZG65HVwhdj6xSCHt5QrGPPHjIxJYqW/bVclck7uBlY2zJ7oKYNK9xc
 rzKcjtOdb/1U17F2P/FtOS6T98817Cf9+njHPv7XzcY1aFFa2RvSAxgIwqqDHcle
 wMtXyHjHOluECt+bWWi5XpGli1YhLnwNOjqVZEFg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 473j1y46p3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 14:48:43 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 556BfLhh022518;
 Fri, 6 Jun 2025 14:48:42 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3tt3ax-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 06 Jun 2025 14:48:42 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 556Emgne26149192
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 6 Jun 2025 14:48:42 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1BFF158055;
 Fri,  6 Jun 2025 14:48:42 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id C65EF5804B;
 Fri,  6 Jun 2025 14:48:41 +0000 (GMT)
Received: from [9.61.255.24] (unknown [9.61.255.24])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  6 Jun 2025 14:48:41 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------h5hVDPN0SliUjrzf0R6h8BJ1"
Message-ID: <9da21b91-3e4c-4a74-8e90-6d70eadf314c@linux.ibm.com>
Date: Fri, 6 Jun 2025 09:48:41 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] migration: Wait for cpr.sock file to appear before
 connecting
To: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Cc: jjherne@linux.ibm.com, steven.sistare@oracle.com, peterx@redhat.com
References: <20250605230808.1278840-1-jhkim@linux.ibm.com>
 <87plfhvvig.fsf@suse.de>
Content-Language: en-US
From: JAEHOON KIM <jhkim@linux.ibm.com>
In-Reply-To: <87plfhvvig.fsf@suse.de>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Nezm13D4 c=1 sm=1 tr=0 ts=6842ffcb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=6IFa9wvqVegA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8
 a=YFT8f6gXuoM21GEUUngA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ZXulRonScM0A:10 a=14-9uApK7O7WhOOCKgUA:9 a=x35VTLcOmODQgmfR:21
 a=_W_S_7VecoQA:10 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: U_Ndz2n7NRn3J9SuBIVDn8i5AxOgZXPz
X-Proofpoint-ORIG-GUID: U_Ndz2n7NRn3J9SuBIVDn8i5AxOgZXPz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA2MDEyOCBTYWx0ZWRfXwV+NWRRvWCrV
 0qriUnHzWRz4at0s6l1WHVrvPtavj8TPN6Mx9aZM0VeH5PvWPVHtJyfZ/rRJwwOWiubmfkyS0VU
 Q8ydIYWyhYQ6X7eNxbfJuF+cWApN9TinPy6wMV+xuKU1MnguVGQ+viaC4BmN29rV19LMv75IqAs
 zZn04/XlEXcLbNW8xGsFEPwjgHneDMnq/4/DRSlGvyGakwtEXCvRh8eGy5ryaHZqtZL6B0vbsy/
 y2geXb7lc611HSfAbfsBdsxd3gxcL3SmPV67vNA64OsfsD183ccI7myfXWKlfzNdXW4U5aaIww9
 lt0xBE3NJY37V+eM6ELTMwNlLlLdS+8hgm7yY6My2qaMeqDI0nVQ5y3GW8icBx5p8vZ9tdPzIjX
 yowH/EdXLmrF/k0LbMlLEzFibmb3TfqYhsMVcs0ONE+XqZzNJvV+OGFiO2W/jGfNaS6dvFZd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_05,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1015
 bulkscore=0 phishscore=0 spamscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 mlxlogscore=915 lowpriorityscore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506060128
Received-SPF: pass client-ip=148.163.156.1; envelope-from=jhkim@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
--------------h5hVDPN0SliUjrzf0R6h8BJ1
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 6/6/2025 8:40 AM, Fabiano Rosas wrote:
> Jaehoon Kim<jhkim@linux.ibm.com> writes:
>
>> When the source VM attempts to connect to the destination VM's Unix
>> domain socket(cpr.sock) during CPR transfer, the socket file might not
>> yet be exist if the destination side hasn't completed the bind
>> operation. This can lead to connection failures when running tests with
>> the qtest framework.
>>
> Could you provide us the output of qtest in this case? Are you simply running
> make check or something else?

Yes, I'm simply running 'make check-qtest-s390x'.

Here's the qtest output from the failure:
  # {
  #     "error": {
  #         "class": "GenericError",
  #         "desc": "Failed to connect to '/tmp/migration-test-ZC7Z72/cpr.sock': No such file or directory"
  #     }
  # }
  not ok /s390x/migration/mode/transfer - ERROR:../tests/qtest/libqtest.c:1453:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
  Bail out!

--------------h5hVDPN0SliUjrzf0R6h8BJ1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 6/6/2025 8:40 AM, Fabiano Rosas
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:87plfhvvig.fsf@suse.de">
      <pre wrap="" class="moz-quote-pre">Jaehoon Kim <a class="moz-txt-link-rfc2396E" href="mailto:jhkim@linux.ibm.com">&lt;jhkim@linux.ibm.com&gt;</a> writes:

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">When the source VM attempts to connect to the destination VM's Unix
domain socket(cpr.sock) during CPR transfer, the socket file might not
yet be exist if the destination side hasn't completed the bind
operation. This can lead to connection failures when running tests with
the qtest framework.

</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Could you provide us the output of qtest in this case? Are you simply running
make check or something else?</pre>
    </blockquote>
    <pre>Yes, I'm simply running 'make check-qtest-s390x'.

Here's the qtest output from the failure:
 # {
 #     "error": {
 #         "class": "GenericError",
 #         "desc": "Failed to connect to '/tmp/migration-test-ZC7Z72/cpr.sock': No such file or directory"
 #     }
 # }
 not ok /s390x/migration/mode/transfer - ERROR:../tests/qtest/libqtest.c:1453:qtest_vqmp_assert_success_ref: assertion failed: (qdict_haskey(response, "return"))
 Bail out!</pre>
  </body>
</html>

--------------h5hVDPN0SliUjrzf0R6h8BJ1--


